-- 6. Показать список книг, которые никто из читателей никогда не брал.
SELECT b.b_id, b.b_name, b.b_year, b.b_quantity
FROM books b
LEFT JOIN subscriptions s ON b.b_id = s.sb_book
WHERE s.sb_book IS NULL;

-- 8. Показать книги, написанные Пушкиным и/или Азимовым (индивидуально или в соавторстве – не важно).
SELECT DISTINCT b.b_id, b.b_name, b.b_year, b.b_quantity
FROM books b
JOIN m2m_books_authors mba ON b.b_id = mba.b_id
JOIN authors a ON a.a_id = mba.a_id
WHERE a.a_name IN (N'А.С. Пушкин', N'А. Азимов')
ORDER BY b.b_name;

-- 10. Показать авторов, написавших более одной книги.
SELECT a.a_id, a.a_name, COUNT(DISTINCT mba.b_id) AS books_count
FROM authors a
JOIN m2m_books_authors mba ON a.a_id = mba.a_id
GROUP BY a.a_id, a.a_name
HAVING COUNT(DISTINCT mba.b_id) > 1;

-- 16. Показать всех читателей, не вернувших книги, и количество невозвращённых книг по каждому такому читателю.
SELECT sub.s_id, sub.s_name, COUNT(*) AS not_returned_books_count
FROM subscriptions s
JOIN subscribers sub ON sub.s_id = s.sb_subscriber
WHERE s.sb_is_active = 'Y'
GROUP BY sub.s_id, sub.s_name;

-- 23. Показать читателя, последним взявшего в библиотеке книгу.
SELECT TOP 1 sub.s_id, sub.s_name, s.sb_start
FROM subscriptions s
JOIN subscribers sub ON sub.s_id = s.sb_subscriber
ORDER BY s.sb_start DESC;