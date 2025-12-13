<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>task1(var3)</title>
    <style>
        :root {
            --base-color: green;
            --text-color: white;
            --hover-base-color: #6ade6a;
        }
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        .page-header {
            font-size: 20px;
            font-weight: bold;
            font-family: "Segoe UI", serif;
            margin: 10px;
        }
        .text-input-label {
            font-family: "Segoe UI", serif;
            font-size: 14px;
            font-weight: bold;
            margin: 5px 10px;
        }
        .text-input {
            width: calc(100% - 20px);
            font-size: 14px;
            font-family: "Segoe UI", serif;
            margin: 10px;
            padding: 5px;
            border-color: var(--base-color);
        }
        .send-button {
            background-color: var(--base-color);
            color: var(--text-color);
            margin: 5px 10px;
            padding: 10px;
        }
        .send-button:hover {
            background-color: var(--hover-base-color);
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form method="post" action="">
        <h1 class="page-header">Слияние массивов</h1>
        <label for="first-text-input" class="text-input-label">Первый набор чисел (через пробел)</label>
        <input type="text" class="text-input" id="first-text-input" name="first-set" required>

        <label for="second-text-input" class="text-input-label">Второй набор чисел (через пробел)</label>
        <input type="text" class="text-input" id="second-text-input" name="second-set" required>

        <input type="submit" value="Отправить" class="send-button">
    </form>
</body>
</html>


<?php
function parse_set($set) {
    $arr = explode(' ', $set); // Разделяем строку по пробелам
    $arr = array_filter($arr, function($value) {
        return !empty($value); // Удаляем пустые элементы
    });

    foreach ($arr as $item) {
        if (!is_numeric($item)) {
            return null;
        }
    }
    return array_values($arr); // Переиндексируем массив
}
function merge_sets($set1, $set2) {
    $arr = $set1;

    foreach ($set2 as $elem) {
        $has_elem = false;
        foreach ($arr as $added_elem) {
            if ($added_elem === $elem) {
                $has_elem = true;
                break;
            }
        }
        if (!$has_elem){
            $arr[] = $elem;
        }
    }
    return $arr;
}

function display_arr($arr) {
    $str = implode(', ', $arr); // Объединяем элементы через запятую
    echo("<span style='margin: 10px;font-size: 14px;font-family: \"Segoe UI\", serif'>$str</span>");
}

function display_error($message) {
    echo("<h1 style='color: red; margin: 10px;font-family: \"Segoe UI\", serif'>$message</h1>");
}


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if(empty($_POST['first-set']) || empty($_POST['second-set'])) {
        display_error("Наборы чисел не должны быть пустыми!");
    }
    else
    {
        $set1 = $_POST['first-set'];
        $set2 = $_POST['second-set'];
        $set1 = parse_set($set1);
        $set2 = parse_set($set2);

        if ($set1 === null || $set2 === null) {
            display_error("Наборы чисел должны содержать только цифры и пробелы!");
        } else {
            $arr = merge_sets($set1, $set2);
            display_arr($arr);
        }
    }


}