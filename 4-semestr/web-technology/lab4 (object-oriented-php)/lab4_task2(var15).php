<?php
function highlight_text($text) {
    // Слова с большой буквы в начале предложения (подчеркнутые)
    $text = preg_replace(
        '/(^|[.!?](\s|\n)+)\b([А-ЯЁA-Z]\w*)\b/u',
        '$1<u>$3</u>',
        $text
    );

    // Слова с большой буквы не в начале предложения (красные)
    $text = preg_replace(
            '/(?<!(^|[.!?]\s))\b([А-ЯЁA-Z]\w*)\b/u',
            '<span style="color:red">$2</span>',
            $text
    );

    // 4+ цифры подряд (зеленые)
    $text = preg_replace(
            '/\d{4,}/',
        '<span style="color:green">$0</span>',
            $text
    );

    return $text;
}

$source_text = isset($_POST['text']) ? $_POST['text'] : false;
if ($source_text) {
    $result = highlight_text($source_text);
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Обработка текста</title>
    <style>
        textarea { width:500px; height:150px; }
        .result { margin-top:20px; padding:10px; border:1px solid #ddd; }
    </style>
</head>
<body>
<form method="post" action="">
    <textarea name="text" placeholder="Введите текст"></textarea>
    <button type="submit">Обработать</button>
</form>

<?php
    if (isset($result)) echo "<div class='result' style='white-space: pre-line;'>$result</div>"
?>
</body>
</html>

