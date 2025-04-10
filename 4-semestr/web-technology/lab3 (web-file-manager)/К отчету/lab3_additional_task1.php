<?php

function search_in_array($arr, $value) {
    foreach ($arr as $item) {
        if ($item === $value) {
            return true;
        }
    }
    return false;
}

function remove_duplicates($array) {
    static $seen = [];
    foreach ($array as $key => $value) {
        if (is_array($value)) {
            $array[$key] = remove_duplicates($value);
        } else {
            if (search_in_array($seen, $value)) {
                unset($array[$key]);
            } else {
                $seen[] = $value;
            }
        }
    }
    return array_values($array);
}

$multi_dim_array = [
    [1, [2, 3, 4], 3],
    [4, 5, 6],
    [1, 2, [2, 3, 13, 5], 3],
    [7, 8, 9],
    [4, 5, 6],
    [10, 11, 12],
    [1, 2, 3],
];

$unique_array = remove_duplicates($multi_dim_array);
echo "<pre>";
print_r($unique_array);
echo "</pre>";
