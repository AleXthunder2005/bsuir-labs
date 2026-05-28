-- 1. Создать представление, позволяющее получать список читателей с количеством находящихся у каждого читателя на руках книг, отображая только должников (есть хотя бы одна просроченная книга).
CREATE VIEW vw_debtors
AS
SELECT 
    sub.s_id,
    sub.s_name,
    COUNT(*) AS books_on_hands
FROM subscriptions s
JOIN subscribers sub ON sub.s_id = s.sb_subscriber
WHERE s.sb_is_active = 'Y'
    AND s.sb_finish < CAST(GETDATE() AS DATE)
GROUP BY sub.s_id, sub.s_name;
GO

-- 5. Создать представление, возвращающее всю информацию из subscriptions, преобразуя даты в формат «ГГГГ-ММ-ДД НН» (полное название дня недели).
CREATE VIEW vw_subscriptions_with_fomatted_dates
AS
SELECT
    sb_id,
    sb_subscriber,
    sb_book,
    FORMAT(sb_start, N'yyyy-MM-dd dddd', 'ru-RU') AS sb_start_formatted,
    FORMAT(sb_finish, N'yyyy-MM-dd dddd', 'ru-RU') AS sb_finish_formatted,
    sb_is_active
FROM subscriptions;
GO

-- 12. Модифицировать схему БД: добавить в subscribers счётчик количества выдач и обеспечить его инкрементирование.
ALTER TABLE subscribers
ADD s_total_books_taken INT NOT NULL DEFAULT 0;
GO

CREATE TRIGGER trg_increment_book_counter
ON subscriptions
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE sub
    SET sub.s_total_books_taken = sub.s_total_books_taken + ins_records.cnt
    FROM subscribers sub
    JOIN (
        SELECT sb_subscriber, COUNT(*) AS cnt
        FROM inserted
        GROUP BY sb_subscriber
    ) ins_records ON sub.s_id = ins_records.sb_subscriber;
END;
GO

-- 13. Создать триггер, запрещающий добавление выдачи, если:
--     - дата выдачи или возврата — воскресенье;
--     - за последние полгода читатель взял более 100 книг;
--     - срок между выдачей и возвратом менее 3 дней.

CREATE TRIGGER trg_validate_subscription_insert
ON subscriptions
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- воскресенье
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE DATENAME(WEEKDAY, sb_start) = N'Воскресенье'
           OR DATENAME(WEEKDAY, sb_finish) = N'Воскресенье'
    )
    BEGIN
        RAISERROR(N'Дата выдачи или возврата приходится на воскресенье.', 16, 1);
        RETURN;
    END;

    -- менее 3 дней
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE DATEDIFF(DAY, sb_start, sb_finish) < 3
    )
    BEGIN
        RAISERROR(N'Срок пользования книгой менее трёх дней.', 16, 1);
        RETURN;
    END;

    -- более 100 книг за последние полгода
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE (
            SELECT COUNT(*)
            FROM subscriptions s
            WHERE s.sb_subscriber = i.sb_subscriber
              AND s.sb_start >= DATEADD(MONTH, -6, GETDATE())
        ) > 100
    )
    BEGIN
        RAISERROR(N'Читатель взял более 100 книг за последние полгода.', 16, 1);
        RETURN;
    END;

    -- если всё корректно — вставляем
    INSERT INTO subscriptions (sb_subscriber, sb_book, sb_start, sb_finish, sb_is_active)
    SELECT sb_subscriber, sb_book, sb_start, sb_finish, sb_is_active
    FROM inserted;
END;
GO

-- 17. Создать триггер, меняющий дату выдачи на текущую, если она меньше текущей на полгода и более.
CREATE TRIGGER trg_correct_old_start_date
ON subscriptions
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE s
    SET sb_start = CAST(GETDATE() AS DATE)
    FROM subscriptions s
    JOIN inserted i ON s.sb_id = i.sb_id
    WHERE i.sb_start <= DATEADD(MONTH, -6, GETDATE());
END;
GO




