<?php
require_once __DIR__ . '/config.php';
$STORE_ROOT = STORE_ROOT;

function move_directory($src, $dst) {
    // Создаем целевую директорию, если не существует
    if (!file_exists($dst)) {
        if (!mkdir($dst, 0777, true)) {
            die("Не удалось создать целевую директорию: $dst");
        }
    }

    $dir = opendir($src);
    if (!$dir) {
        die("Не удалось открыть исходную директорию: $src");
    }

    while (($file = readdir($dir)) !== false) {
        if ($file === '.' || $file === '..') {
            continue;
        }

        $srcPath = $src . DIRECTORY_SEPARATOR . $file;
        $dstPath = $dst . DIRECTORY_SEPARATOR . $file;

        if (is_dir($srcPath)) {
            // Рекурсивно перемещаем поддиректорию
            move_directory($srcPath, $dstPath);
        } else {
            // Перемещаем файл
            if (!rename($srcPath, $dstPath)) {
                // Если rename не сработал, пробуем копировать и удалять
                if (copy($srcPath, $dstPath)) {
                    unlink($srcPath);
                } else {
                    die("Ошибка при перемещении файла: $srcPath");
                }
            }
        }
    }
    closedir($dir);

    // Удаляем пустую исходную директорию
    @rmdir($src);
}

// Получаем и очищаем пути
$relative_move_from_path = isset($_POST['move_from_path']) ? trim($_POST['move_from_path'], '/\\') : '';
$relative_move_to_path = isset($_POST['move_to_path']) ? trim($_POST['move_to_path'], '/\\') : '';

if (empty($relative_move_from_path) || empty($relative_move_to_path)) {
    die("Не указаны пути для перемещения");
}

// Формируем полные пути
$source_path = $STORE_ROOT . DIRECTORY_SEPARATOR . str_replace(['/', '\\'], DIRECTORY_SEPARATOR, $relative_move_from_path);
$destination_path = $STORE_ROOT . DIRECTORY_SEPARATOR . str_replace(['/', '\\'], DIRECTORY_SEPARATOR, $relative_move_to_path);

// Проверяем существование исходного пути
if (!file_exists($source_path)) {
    die("Исходный файл или директория не существует: " . basename($source_path));
}

// Если перемещаем файл в директорию, добавляем имя файла к целевому пути
if (is_file($source_path) && is_dir($destination_path)) {
    $filename = basename($source_path);
    $destination_path = rtrim($destination_path, DIRECTORY_SEPARATOR) . DIRECTORY_SEPARATOR . $filename;
}
// Если перемещаем директорию, добавляем ее имя к целевому пути
elseif (is_dir($source_path) && is_dir($destination_path)) {
    $dirname = basename($source_path);
    $destination_path = rtrim($destination_path, DIRECTORY_SEPARATOR) . DIRECTORY_SEPARATOR . $dirname;
}

// Перемещаем файл или директорию
if (is_file($source_path)) {
    // Создаем целевую директорию, если нужно
    $dest_dir = dirname($destination_path);
    if (!file_exists($dest_dir)) {
        mkdir($dest_dir, 0777, true);
    }

    if (!rename($source_path, $destination_path)) {
        if (copy($source_path, $destination_path)) {
            unlink($source_path);
        } else {
            die("Ошибка при перемещении файла: " . basename($source_path));
        }
    }
} elseif (is_dir($source_path)) {
    move_directory($source_path, $destination_path);
}

// Возвращаемся на предыдущую страницу
header("Location: " . ($_SERVER['HTTP_REFERER'] ?? 'index.php'));
exit();