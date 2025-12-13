<?php
// Проверяем, есть ли GET-параметры
if (!empty($_GET)) {
    echo "<h2>Результаты анализа GET-параметров:</h2>";
    echo "<ul>";

    // Перебираем все GET-параметры
    foreach ($_GET as $key => $value) {
        echo "<li><strong>Параметр:</strong> $key, <strong>Значение:</strong> $value, <strong>Тип:</strong> ";

        // Определяем тип данных
        if (is_numeric($value)) {
            if (strpos($value, '.') !== false) {
                echo "дробное число";
            } else {
                echo "целое число";
            }
        } else {
            echo "строка";
        }

        echo "</li>";
    }

    echo "</ul>";
} else {
    echo "<h2>GET-параметры не переданы.</h2>";
}
