
-- 1. Создать хранимую процедуру, которая:
--    a. добавляет каждой книге два случайных жанра;
--    b. отменяет совершённые действия, если в процессе работы хотя бы одна операция вставки завершилась ошибкой в силу дублирования значения первичного ключа таблицы «m2m_books_genres» (т.е. у такой книги уже был такой жанр).
CREATE PROCEDURE dbo.sp_add_two_random_genres
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

    BEGIN TRY
        DECLARE @b_id INT;
        DECLARE @g1 INT;
        DECLARE @g2 INT;

        DECLARE book_cursor CURSOR FOR
            SELECT b_id FROM books;

        OPEN book_cursor;
        FETCH NEXT FROM book_cursor INTO @b_id;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- выбираем два случайных жанра
            SELECT TOP 2 @g1 = g_id
            FROM genres
            ORDER BY NEWID();

            SELECT TOP 1 @g2 = g_id
            FROM genres
            WHERE g_id <> @g1
            ORDER BY NEWID();

            -- вставляем
            INSERT INTO m2m_books_genres (b_id, g_id) VALUES (@b_id, @g1);
            INSERT INTO m2m_books_genres (b_id, g_id) VALUES (@b_id, @g2);

            FETCH NEXT FROM book_cursor INTO @b_id;
        END

        CLOSE book_cursor;
        DEALLOCATE book_cursor;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH
END;
GO

-- 2. Создать хранимую процедуру, которая:
--    a. увеличивает значение поля «b_quantity» для всех книг в два раза;
--    b. отменяет совершённое действие, если по итогу выполнения операции среднее количество экземпляров книг превысит значение 50.
CREATE PROCEDURE dbo.sp_double_book_quantity
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

    BEGIN TRY
        -- удвоение
        UPDATE books
        SET b_quantity = b_quantity * 2;

        -- проверка среднего
        DECLARE @avg FLOAT;
        SELECT @avg = AVG(CAST(b_quantity AS FLOAT)) FROM books;

        IF @avg > 50
        BEGIN
            RAISERROR(N'Среднее количество книг превысило 50.', 16, 1);
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH
END;
GO

-- 3. Написать запросы, которые, будучи выполненными параллельно, обеспечивали бы следующий эффект:
--    a. первый запрос должен считать количество выданных на руки и возвращённых в библиотеку книг и не зависеть от запросов на обновление таблицы «subscriptions» (не ждать их завершения);
--    b. второй запрос должен инвертировать значения поля «sb_is_active» таблицы subscriptions с «Y» на «N» и наоборот и не зависеть от первого запроса (не ждать его завершения).
SELECT 
    SUM(CASE WHEN sb_is_active = 'Y' THEN 1 ELSE 0 END) AS on_hand,
    SUM(CASE WHEN sb_is_active = 'N' THEN 1 ELSE 0 END) AS returned
FROM subscriptions
WITH (NOLOCK);

UPDATE subscriptions
SET sb_is_active = CASE WHEN sb_is_active = 'Y' THEN 'N' ELSE 'Y' END;

-- 5.	Написать код, в котором запрос, инвертирующий значения поля «sb_is_active» таблицы «subscriptions» с «Y» на «N» и наоборот, будет иметь максимальные шансы на успешное завершение в случае возникновения ситуации взаимной блокировки с другими транзакциями.
UPDATE subscriptions WITH (ROWLOCK)
SET sb_is_active = CASE WHEN sb_is_active = 'Y' THEN 'N' ELSE 'Y' END;

-- 6.	Создать на таблице «subscriptions» триггер, определяющий уровень изолированности транзакции, в котором сейчас проходит операция обновления, и отменяющий операцию, если уровень изолированности транзакции отличен от REPEATABLE READ.
CREATE TRIGGER trg_check_isolation
ON subscriptions
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @iso_level INT;
    SET @iso_level = CONVERT(INT, SESSIONPROPERTY('isolation level'));

    IF @iso_level <> 3
    BEGIN
        RAISERROR(N'Транзакция должна быть в режиме REPEATABLE READ.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO