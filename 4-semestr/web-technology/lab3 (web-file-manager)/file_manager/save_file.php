<?php
$file_path = $_POST['file_path'] ?? '';
$content = $_POST['content'] ?? '';

if (file_exists($file_path)) {
    file_put_contents($file_path, $content);
}

// Возвращаемся на предыдущую страницу
header("Location: " . $_SERVER['HTTP_REFERER']);
exit();