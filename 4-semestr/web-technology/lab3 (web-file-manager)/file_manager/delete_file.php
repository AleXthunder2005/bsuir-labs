<?php
// Базовый путь к хранилищу
require_once __DIR__ . '/config.php';
$STORE_ROOT = STORE_ROOT;

// Функция для рекурсивного удаления директории
function delete_directory($dir) {  //dir - полный путь
    if (!file_exists($dir)) {
        return false;
    }

    $files = scandir($dir);

    foreach ($files as $file) {
        $path = $dir . DIRECTORY_SEPARATOR . $file;

        if ($file === '.' || $file === '..') {continue;}

        if (is_dir($path)) {
            delete_directory($path); // Рекурсивный вызов для поддиректорий
        } else {
            unlink($path); // Удаление файла
        }
    }

    return rmdir($dir); // Удаление пустой директории
}

// Получаем относительный путь из формы
$relative_path = $_POST['delete_from_path'] ?? "";
if (empty($relative_path)) {
    die("Некорректный путь к файлу $relative_path при удалении");
}

$file_path = $STORE_ROOT . DIRECTORY_SEPARATOR . $relative_path;
// Проверяем существование пути
if (file_exists($file_path)) {
    if (is_file($file_path)) {
        // Удаление файла
        if (!unlink($file_path)) {
            die("Ошибка при удалении файла");
        }
    } elseif (is_dir($file_path)) {
        //Удаление директории
        if (!delete_directory($file_path)) {
            die("Ошибка при удалении директории");
        }
    }
} else {
    die("Файл или директория не существует");
}

// Возвращаемся на предыдущую страницу
header("Location: " . ($_SERVER['HTTP_REFERER'] ?? 'index.php'));
exit();