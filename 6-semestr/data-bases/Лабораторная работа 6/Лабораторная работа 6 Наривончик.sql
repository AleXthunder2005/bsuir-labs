-- 1. Создать хранимую функцию, получающую на вход идентификатор
--    читателя и возвращающую список идентификаторов книг,
--    которые он уже прочитал и вернул в библиотеку.

CREATE FUNCTION dbo.fn_get_books_by_subscriber_id
(
    @subscriber_id INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT sb_book
    FROM subscriptions
    WHERE sb_subscriber = @subscriber_id
      AND sb_is_active = 'N'
);
GO

-- 3. Создать хранимую функцию, получающую на вход идентификатор
--    читателя и возвращающую 1, если у читателя на руках сейчас
--    менее десяти книг, и 0 в противном случае.

CREATE FUNCTION dbo.fn_can_take_more_books
(
    @subscriber_id INT
)
RETURNS BIT
AS
BEGIN
    DECLARE @result BIT;

    IF (
        SELECT COUNT(*)
        FROM subscriptions
        WHERE sb_subscriber = @subscriber_id
          AND sb_is_active = 'Y'
    ) < 10
        SET @result = 1;
    ELSE
        SET @result = 0;

    RETURN @result;
END;
GO

-- 5. Создать хранимую процедуру, обновляющую все поля типа DATE
--    (если такие есть) всех записей указанной таблицы
--    на значение текущей даты.

CREATE PROCEDURE dbo.sp_update_all_dates_to_current
    @table_name SYSNAME
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX) = N'';
    DECLARE @update_list NVARCHAR(MAX) = N'';

    SELECT @update_list = STRING_AGG(
        QUOTENAME(c.name) + N' = CAST(GETDATE() AS DATE)', 
        N', '
    )
    FROM sys.columns c
    JOIN sys.types t ON c.user_type_id = t.user_type_id
    WHERE c.object_id = OBJECT_ID(@table_name)
      AND t.name = 'date';

    IF @update_list IS NOT NULL
    BEGIN
        SET @sql = N'UPDATE ' + QUOTENAME(@table_name)
                 + N' SET ' + @update_list + N';';

        EXEC sp_executesql @sql;
    END
END;
GO

-- 9. Создать хранимую процедуру, автоматически создающую и наполняющую таблицу «arrears» (должники).

CREATE PROCEDURE dbo.sp_create_and_fill_arrears
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('arrears', 'U') IS NOT NULL
        DROP TABLE arrears;

    CREATE TABLE arrears
    (
        s_id INT NOT NULL,
        s_name NVARCHAR(150) NOT NULL
    );

    INSERT INTO arrears (s_id, s_name)
    SELECT DISTINCT sub.s_id, sub.s_name
    FROM subscriptions s
    JOIN subscribers sub ON sub.s_id = s.sb_subscriber
    WHERE s.sb_is_active = 'Y'
      AND s.sb_finish < CAST(GETDATE() AS DATE);
END;
GO

-- 11. Создать хранимую процедуру, удаляющую все представления, для которых SELECT COUNT(1) FROM <view> < 10.

CREATE PROCEDURE dbo.sp_drop_small_views
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @view_name SYSNAME;
    DECLARE @sql NVARCHAR(MAX);

    DECLARE view_cursor CURSOR FOR
        SELECT name
        FROM sys.views;

    OPEN view_cursor;
    FETCH NEXT FROM view_cursor INTO @view_name;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @sql = N'
            IF (SELECT COUNT(1) FROM ' + QUOTENAME(@view_name) + N') < 10
                DROP VIEW ' + QUOTENAME(@view_name) + N';';

        EXEC sp_executesql @sql;

        FETCH NEXT FROM view_cursor INTO @view_name;
    END

    CLOSE view_cursor;
    DEALLOCATE view_cursor;
END;
GO
