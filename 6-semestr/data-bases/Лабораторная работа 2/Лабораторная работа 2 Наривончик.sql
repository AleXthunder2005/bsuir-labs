-- 2. Показать всю информацию о жанрах.
SELECT *
FROM genres;


-- 3. Показать без повторений идентификаторы книг, которые были взяты читателями.
SELECT DISTINCT sb_book
FROM subscriptions;


-- 9. Показать список авторов в обратном алфавитном порядке (т.е. «Я → А»).
SELECT a_name
FROM authors
ORDER BY a_name DESC;


-- 12. Показать идентификатор одного (любого) читателя, взявшего в библиотеке больше всего книг.
SELECT TOP 1 sb_subscriber
FROM subscriptions
GROUP BY sb_subscriber
ORDER BY COUNT(*) DESC;


-- 15. Показать, сколько в среднем экземпляров книг есть в библиотеке.
SELECT AVG(CAST(b_quantity AS FLOAT)) AS avg_books
FROM books;