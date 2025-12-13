-- ========== Создать БД и настройки по умолчанию ==========
CREATE DATABASE IF NOT EXISTS library_db
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;
USE library_db;

-- Установим движок и кодировку на уровень сессии (для явности)
SET default_storage_engine = 'InnoDB';
SET NAMES utf8mb4;

-- ========== Справочники ==========
CREATE TABLE publishers (
    pub_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    pub_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (pub_id),
    UNIQUE KEY uq_publishers_name (pub_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE categories (
    category_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(120) NOT NULL,
    PRIMARY KEY (category_id),
    UNIQUE KEY uq_categories_name (category_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE authors (
    auth_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    auth_lastname VARCHAR(100) NOT NULL,
    auth_firstname VARCHAR(100) NOT NULL,
    auth_middlename VARCHAR(100),
    auth_pseudonym VARCHAR(150),
    auth_country VARCHAR(100) NOT NULL,
    PRIMARY KEY (auth_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE keywords (
    key_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    key_name VARCHAR(120) NOT NULL,
    PRIMARY KEY (key_id),
    UNIQUE KEY uq_keywords_name (key_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ========== Логические книги ==========
CREATE TABLE books (
    book_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    book_title VARCHAR(500) NOT NULL,
    book_publish_year YEAR NOT NULL,
    book_pub_id INT UNSIGNED NOT NULL,                 -- FK -> publishers
    book_category_id INT UNSIGNED NOT NULL,            -- FK -> categories
    book_description TEXT,
    PRIMARY KEY (book_id),
    CONSTRAINT fk_books_publisher FOREIGN KEY (book_pub_id) REFERENCES publishers(pub_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_books_category  FOREIGN KEY (book_category_id) REFERENCES categories(category_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_books_title (book_title(255)),
    FULLTEXT KEY ft_books_title_descr (book_title, book_description)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ========== М-Н связи: книги-авторы ==========
CREATE TABLE book_authors (
    ba_book_id INT UNSIGNED NOT NULL,
    ba_auth_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (ba_book_id, ba_auth_id),
    CONSTRAINT fk_ba_book FOREIGN KEY (ba_book_id) REFERENCES books(book_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_ba_auth FOREIGN KEY (ba_auth_id) REFERENCES authors(auth_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ========== М-Н связи: книги-ключевые слова ==========
CREATE TABLE book_keywords (
    bk_book_id INT UNSIGNED NOT NULL,
    bk_key_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (bk_book_id, bk_key_id),
    CONSTRAINT fk_bk_book FOREIGN KEY (bk_book_id) REFERENCES books(book_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_bk_key FOREIGN KEY (bk_key_id) REFERENCES keywords(key_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ========== Экземпляры ==========
CREATE TABLE copies (
    copy_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    copy_book_id INT UNSIGNED NOT NULL,
    copy_barcode VARCHAR(100) NOT NULL,
    -- состояние: новая, хорошая, удовлетворительная, плохая
    copy_condition ENUM('new','good','fair','bad') NOT NULL DEFAULT 'good',
    -- статус экземпляра
    copy_status ENUM('in_stock','loaned','lost','written_off','reserved') NOT NULL DEFAULT 'in_stock',
    notes VARCHAR(1000),
    PRIMARY KEY (copy_id),
    UNIQUE KEY uq_copy_barcode (copy_barcode),
    CONSTRAINT fk_copies_book FOREIGN KEY (copy_book_id) REFERENCES books(book_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_copies_book (copy_book_id),
    INDEX idx_copies_status (copy_status),
    INDEX idx_copies_condition (copy_condition)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ========== Читатели ==========
CREATE TABLE readers (
    reader_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    reader_fullname VARCHAR(300) NOT NULL,
    reader_passport VARCHAR(50) NOT NULL,
    reader_birthdate DATE NOT NULL,
    reader_phone VARCHAR(50),
    reader_email VARCHAR(255),
    reader_address VARCHAR(500),
    reader_reg_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reader_is_active ENUM('active','blocked') NOT NULL DEFAULT 'active',
    PRIMARY KEY (reader_id),
    UNIQUE KEY uq_reader_passport (reader_passport),
    INDEX idx_reader_email (reader_email),
    INDEX idx_reader_phone (reader_phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ========== Сотрудники ==========
CREATE TABLE employees (
    emp_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    emp_fullname VARCHAR(300) NOT NULL,
    emp_position VARCHAR(150),
    emp_login VARCHAR(100) NOT NULL,
    emp_password_hash CHAR(128) NOT NULL, -- рассчитано на хранение безопасного хеша (например SHA-512/argon2)
    PRIMARY KEY (emp_id),
    UNIQUE KEY uq_emp_login (emp_login)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ========== Выдачи ==========
CREATE TABLE loans (
    loan_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    loan_copy_id INT UNSIGNED NOT NULL,
    loan_reader_id INT UNSIGNED NOT NULL,
    loan_emp_id INT UNSIGNED NOT NULL,
    loan_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    loan_due_date DATE NOT NULL,
    loan_return_date DATE,
    loan_overdue_days INT UNSIGNED, -- вычисляется триггером при возврате
    PRIMARY KEY (loan_id),
    CONSTRAINT fk_loans_copy FOREIGN KEY (loan_copy_id) REFERENCES copies(copy_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_loans_reader FOREIGN KEY (loan_reader_id) REFERENCES readers(reader_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_loans_emp FOREIGN KEY (loan_emp_id) REFERENCES employees(emp_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_loans_copy (loan_copy_id),
    INDEX idx_loans_reader (loan_reader_id),
    INDEX idx_loans_emp (loan_emp_id),
    INDEX idx_loans_due (loan_due_date),
    INDEX idx_loans_return (loan_return_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Триггер: при обновлении loan_return_date вычисляем loan_overdue_days
DELIMITER $$
CREATE TRIGGER trg_loans_set_overdue
BEFORE UPDATE ON loans
FOR EACH ROW
BEGIN
    IF NEW.loan_return_date IS NOT NULL THEN
        -- Если дата возврата после срока, вычисляем разницу в днях, иначе 0
        IF DATEDIFF(NEW.loan_return_date, NEW.loan_due_date) > 0 THEN
            SET NEW.loan_overdue_days = DATEDIFF(NEW.loan_return_date, NEW.loan_due_date);
        ELSE
            SET NEW.loan_overdue_days = 0;
        END IF;
    ELSE
        -- Если возврат ещё не произошёл, оставляем NULL (или можно считать от текущей даты, но это небезопасно для триггеров)
        SET NEW.loan_overdue_days = NULL;
    END IF;
END$$
DELIMITER ;

-- ========== Штрафы ==========
CREATE TABLE fines (
    fine_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    fine_loan_id INT UNSIGNED NOT NULL,
    fine_amount DECIMAL(10,2) NOT NULL,
    fine_reason VARCHAR(300) NOT NULL,
    fine_paid ENUM('yes','no') NOT NULL DEFAULT 'no',
    fine_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (fine_id),
    CONSTRAINT fk_fines_loan FOREIGN KEY (fine_loan_id) REFERENCES loans(loan_id) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_fines_loan (fine_loan_id),
    INDEX idx_fines_paid (fine_paid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ========== Бронирования ==========
CREATE TABLE reservations (
    reserv_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    reserv_copy_id INT UNSIGNED NOT NULL,
    reserv_reader_id INT UNSIGNED NOT NULL,
    reserv_start_date DATETIME NOT NULL,
    reserv_end_date DATETIME NOT NULL,
    reserv_status ENUM('active','completed','cancelled','expired') NOT NULL DEFAULT 'active',
    PRIMARY KEY (reserv_id),
    CONSTRAINT fk_reserv_copy FOREIGN KEY (reserv_copy_id) REFERENCES copies(copy_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_reserv_reader FOREIGN KEY (reserv_reader_id) REFERENCES readers(reader_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_reserv_copy (reserv_copy_id),
    INDEX idx_reserv_reader (reserv_reader_id),
    INDEX idx_reserv_status (reserv_status),
    INDEX idx_reserv_dates (reserv_start_date, reserv_end_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ========== Дополнительные индексы и оптимизации ==========
-- Индекс на сочетание книги и издателя (если поиск по издателю+названию)
CREATE INDEX idx_books_pub_title ON books (book_pub_id, book_title(150));

-- Индекс на авторов для быстрого получения всех книг автора (создан через book_authors -> fk индексы)
CREATE INDEX idx_book_authors_auth ON book_authors (ba_auth_id);

-- Индексы для fulltext поиска (books уже имеет FULLTEXT)
-- Если нужна поддержка русской морфологии для fulltext — требуется дополнительная конфигурация на уровне сервера (прим.: не в этом скрипте).

-- ========== Права доступа (пример) ==========
-- Создаём учётную запись администратора БД для работы с этой базой (замените пароль)
CREATE USER IF NOT EXISTS 'library_admin'@'%' IDENTIFIED BY 'CHANGE_ME_secure_password';
GRANT ALL PRIVILEGES ON library_db.* TO 'library_admin'@'%';
FLUSH PRIVILEGES;

-- Создадим роль для обычных библиотекарей (ограниченные права)
CREATE USER IF NOT EXISTS 'librarian'@'localhost' IDENTIFIED BY 'CHANGE_ME_librarian';
GRANT SELECT, INSERT, UPDATE, DELETE ON library_db.* TO 'librarian'@'localhost';
-- Рекомендуется в реальной эксплуатации назначать более тонкие права (например, запрет на DROP, TRUNCATE, ограничение по таблицам)
FLUSH PRIVILEGES;

-- ========== Конец скрипта ==========
