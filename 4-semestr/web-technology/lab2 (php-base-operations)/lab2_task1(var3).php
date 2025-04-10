<?php

$arr = [11, [[31,32,33,[41,42,[51,[61,62,63,64],52,53],43]], 21,22,23],12,13];

display_array($arr);

function display_array($array, $level = 0) {
    $colors = ['red','blue','green','purple','yellow'];

    $color = $level < 4 ? $colors[$level] : 'yellow';

    echo "<ul style='color: $color;'>";
    foreach ($array as $value) {
        echo "<li>";
        if (is_array($value)) {
            display_array($value, $level + 1);
        } else {
            echo "$value";
        }
        echo "</li>";
    }
    echo "</ul>";
}
