<?php
// Проверяем, передан ли параметр командной строки
if ($argc < 2) {
    die("Укажите количество строк в качестве параметра командной строки.\n");
}

// Получаем количество строк из параметра командной строки
$rows = (int)$argv[1];

// Проверяем, что количество строк больше 0
if ($rows <= 0) {
    die("Количество строк должно быть больше 0.\n");
}

// Генерация HTML-таблицы
echo "<!DOCTYPE html>
<html lang='ru'>
<head>
    <meta charset='UTF-8'>
    <title>Таблица с градацией цвета</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse; 
        }
        td {
            padding: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>Таблица с градацией цвета</h1>
    <table border='1'>";

// Генерация строк таблицы
for ($i = 0; $i < $rows; $i++) {
    // Вычисляем оттенок серого
    $gray_value = round(255 * ($i / ($rows - 1))); // От 0 до 255
    $gray_hex = str_pad(dechex($gray_value), 2, '0', STR_PAD_LEFT); // Дополняем до двух символов
    $bg_color = "#$gray_hex$gray_hex$gray_hex"; // Формируем цвет в формате #RRGGBB

    // Выводим строку таблицы
    echo "<tr style='background-color: $bg_color;'>";
    echo "<td>Строка " . ($i + 1) . "</td>";
    echo "</tr>";
}

echo "</table>
</body>
</html>";
