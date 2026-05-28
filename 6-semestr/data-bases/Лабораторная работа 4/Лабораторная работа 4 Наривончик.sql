-- 1. Добавить в базу данных информацию о троих новых читателях: «Орлов О.О.», «Соколов С.С.», «Беркутов Б.Б.».
INSERT INTO subscribers (s_name)
VALUES 
    (N'Орлов О.О.'),
    (N'Соколов С.С.'),
    (N'Беркутов Б.Б.');

-- 4. Отметить все выдачи с идентификаторами ≤ 50 как возвращённые.
UPDATE subscriptions
SET sb_is_active = 'N'
WHERE sb_id <= 50;

-- 5. Для всех выдач, произведённых до 1-го января 2012-го года, уменьшить значение дня выдачи на 3.
UPDATE subscriptions
SET sb_start = DATEADD(DAY, -3, sb_start)
WHERE sb_start < '2012-01-01';

-- 8. Удалить все книги, относящиеся к жанру «Классика».
DELETE FROM books
WHERE b_id IN (
    SELECT mbg.b_id
    FROM m2m_books_genres mbg
    JOIN genres g ON g.g_id = mbg.g_id
    WHERE g.g_name = N'Классика'
);

-- 10. Добавить в базу данных жанры «Политика», «Психология», «История».
INSERT INTO genres (g_name)
VALUES
    (N'Политика'),
    (N'Психология'),
    (N'История');