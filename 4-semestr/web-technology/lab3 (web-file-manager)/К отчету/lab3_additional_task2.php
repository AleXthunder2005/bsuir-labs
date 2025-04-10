<?php

// Проверяем, передан ли параметр с именем файла
if (count($argv) < 1) {
    die("Ошибка: Укажите имя файла как параметр командной строки.\nПример: php lab3_additional_task2.php filename.txt\n");
}

$filename = $argv[1];

// Проверяем существование файла
if (!file_exists($filename)) {
    die("Ошибка: Файл '$filename' не найден.\n");
}

// Проверяем, является ли файл обычным файлом
if (!is_file($filename)) {
    die("Ошибка: '$filename' не является обычным файлом.\n");
}

if (substr(strtolower($filename), -4) !== '.txt') {
    die("Ошибка: '$filename' должен иметь расширение .txt\n");
}

if (!is_readable($filename)) {
    die("Ошибка: '$filename' не доступен для чтения.\n");
}

// Читаем содержимое файла
$lines = file($filename, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

if ($lines === false) {
    die("Ошибка: Не удалось прочитать файл '$filename'.\n");
}

function caseInsensitiveCompare($a, $b) {
    $aLower = strtolower($a);
    $bLower = strtolower($b);

    if ($aLower == $bLower) {
        return 0;
    }
    return ($aLower < $bLower) ? -1 : 1;
}

function selectionSort(&$string_list, callable $comparator) {
    $length = count($string_list);

    for ($i = 0; $i < $length - 1; $i++) {
        $minIndex = $i;

        for ($j = $i + 1; $j < $length; $j++) {
            if ($comparator($string_list[$j], $string_list[$minIndex]) < 0) {
                $minIndex = $j;
            }
        }

        if ($minIndex != $i) {
            $temp = $string_list[$i];
            $string_list[$i] = $string_list[$minIndex];
            $string_list[$minIndex] = $temp;
        }
    }
}

selectionSort($lines, function($a, $b) { return caseInsensitiveCompare($a, $b);});

$sortedContent = implode(PHP_EOL, $lines);

if (file_put_contents($filename, $sortedContent) === false) {
    die("Ошибка: Не удалось записать в файл '$filename'.\n");
}

echo "Файл '$filename' успешно отсортирован по алфавиту.\n";
