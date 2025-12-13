<?php
// Настройки подключения к БД
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', 'Fasad123698745)');
define('DB_NAME', 'site_db');

// Базовые настройки сайта
define('SITE_TITLE', 'Сайт');
define('SITE_URL', 'http://localhost');

// Подключение к БД
try {
    $db = new PDO(
        "mysql:host=".DB_HOST.";dbname=".DB_NAME.";charset=utf8",
        DB_USER,
        DB_PASS
    );
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("Ошибка подключения: " . $e->getMessage());
}

// Функция для безопасного вывода
function safe_output($data) {
    return htmlspecialchars($data, ENT_QUOTES, 'UTF-8');
}
