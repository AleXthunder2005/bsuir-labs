<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Генерация таблицы</title>
</head>
<body>
<h1>Генерация таблицы</h1>
<form method="POST" action="">
    <label for="rows">Введите количество строк (не менее 10):</label>
    <input type="number" id="rows" name="rows" min="10" required>
    <button type="submit">Сгенерировать таблицу</button>
</form>
</body>
</html>


<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $rows = (int)$_POST['rows'];

    echo '<table border="1">';
    for ($i = 1; $i <= $rows; $i++) {
        if ($i % 5 === 0) {
            $bg_color = 'green';
        } else {
            $gray_value = dechex(round(255 * (($i - 1) / ($rows - 1))));
            $gray_value = str_pad($gray_value, 2, '0', STR_PAD_LEFT);
            $bg_color = "#$gray_value$gray_value$gray_value";
        }

        echo "<tr style='background-color: $bg_color;'>";
        echo "<td>Строка $i: $bg_color</td>";
        echo "</tr>";
    }
    echo '</table>';
}
