<?php
require_once __DIR__ . '/config.php';
include_once __DIR__ . '/display_store.php';
$STORE_ROOT = STORE_ROOT;
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Файловый менеджер</title>
    <style>
        * {margin: 0; padding: 0; box-sizing: border-box;}
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 900px;
            margin: 20px auto;
            padding: 40px;
            border: 1px solid #aaaaaa;
            background-color: ghostwhite;
            font-size: 18px;
            border-radius: 30px;
        }
        h1 {
            text-align: center;
        }

        .control-panel {
            margin: 20px;
            padding: 10px;
            border: 1px solid #333;
        }

        .route {
            margin-bottom: 10px;
            padding: 8px;
            a {
                text-decoration: none;
                color: #0066cc;
            }
            a:hover {
                text-decoration: underline;
            }
            .file-name {
                color: #333;
            }
            .file-name:hover {
                color: #666;
                cursor:pointer;
            }
        }
        .route-separator {
            margin: 0 5px;
            color: #999;
        }


        .input-element {
            width: 100%;
            font-size: 18px;
            margin-bottom: 10px;
        }
        label {
            display: block;
            margin-top: 10px;
        }
        .send-button {
            padding: 10px 50px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            background-color: #047804;
            margin-top: 15px;
        }
        .send-button:hover {
            cursor: pointer;
            background-color: #37ab37;
        }
        .results {
            margin-top: 20px;
            font-size: 14px;
        }
        ul {
            list-style: none;
            padding-left: 20px;
        }
        li {
            margin-bottom: 5px;
        }
        .link {
            text-decoration: none;
            color: inherit;
        }
        .link:hover {
            text-decoration: underline;
        }
        .file {
            color: #333;
        }
        .directory {
            font-weight: bold;
            color: #0066cc;
        }
        .file-info {
            color: #666;
            font-size: 12px;
            margin-left: 5px;
        }

        .move-container {
            display: flex;
            justify-content: space-between;
        }
        .path-input-text {
            display: block;
            width: 100%;
            font-size: 18px;
        }
        .move-button {
            padding: 5px 50px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            background-color: #047804;
            margin-left: 15px;
        }
        .move-button:hover{
            cursor: pointer;
            background-color: #37ab37;
        }
        .delete-button {
            padding: 5px 50px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            background-color: #047804;
            margin-top: 15px;
            width: 100%;

        }
        .delete-button:hover{
            cursor: pointer;
            background-color: #37ab37;
        }
        .upload-file-button {
            padding: 5px 50px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            background-color: #047804;
            margin-top: 15px;
            width: 100%;

        }
        .upload-file-button:hover{
            cursor: pointer;
            background-color: #37ab37;
        }

        .preview {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            background: white;
            border-radius: 10px;
        }
        .thumbnail {
            /*Для картинки*/
            max-width: 800px;
            margin: 20px auto 0;
            border-radius: 10px;
        }
        .textarea {
            width: 100%;
            height: 400px;
            resize: none;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Файловый менеджер</h1>

    <div class="route">
        <?php
        //ВЫВОД МАРШРУТА
        //из GET параметра взяли текущую директорию для построения маршрута
        $current_dir = isset($_GET['dir']) ? $_GET['dir'] : '';      //...store/ $current_dir
        $file_to_view = isset($_GET['file']) ? $_GET['file'] : '';

        // Отображение маршрута
        $path_parts = explode('/', trim($current_dir, '/'));
        $route_path = '';
        echo '<a href="?dir=">store</a>';
        echo '<span class="route-separator">/</span>';

        //Создаём ссылки для каждой части маршрута
        foreach ($path_parts as $part) {
            if (!empty($part)) {
                $route_path .= '/' . $part;
                echo '<a href="?dir=' . urlencode($route_path) . '">' . $part . '</a>';
                echo '<span class="route-separator">/</span>';
            }
        }
        echo "<span class='file-name'>$file_to_view</span>"; //Дописали имя файла в конце маршрута
        ?>
    </div>

    <?php
        $file_path = $STORE_ROOT . $current_dir . '/' . $file_to_view;
        $relative_path = str_replace($STORE_ROOT, '', $file_path);
    ?>

    <div class="contol-panel">
        <form method="post" action="move_file.php">
            <!--Работаем с относительными путями-->
            <?php echo '<input type="hidden" name="move_from_path" value="' . $relative_path . '">'?>
            <label for="move-to-path">Переместить в:</label>
            <div class="move-container">
                <input class="path-input-text" type="text" id="move-to-path" name="move_to_path" required>
                <button type="submit" class="move-button">Переместить</button>
            </div>
        </form>

        <?php
            if (is_dir($file_path)) {
                echo '<form method="post" action="upload_file.php" enctype="multipart/form-data">';
                echo '<input type="hidden" name="upload_to_path" value="' .$relative_path . '">';
                echo '<input type="file" id="uploaded_files" name="uploaded_files[]" multiple required>';/*class="upload-file-button"*/
                echo '<button type="submit" class="delete-button">Загрузить сюда</button>';
                echo '</form>';
            }
        ?>

        <form method="post" action="delete_file.php">
            <?php echo '<input type="hidden" name="delete_from_path" value="' . $relative_path . '">'?>
            <button type="submit" class="delete-button">Удалить</button>
        </form>
    </div>

    <div class="results">
        <?php
        if (!empty($file_to_view)) {
            // Просмотр файла
            if (file_exists($file_path)) {
                //на основании уникальных байтов или расширения возвращает:
                //     'image/...' для картинок
                //     'text/...' для текстовых файлов
                //     'audio/...' 'video/...' 'application/pdf' ...
                $mime = mime_content_type($file_path);

                if (strpos($mime, 'image/') === 0) {
                    //Вывод превью картинки
                    echo '<div class="preview">';
                    echo "<h3 class='preview-file-name'>$file_to_view</h3>";
                    echo '<img src="store/' . $relative_path . '" class="thumbnail">';
                    echo '</div>';
                }
                elseif (strpos($mime, 'text/') === 0) {
                    //Вывод текста с его сохранением
                    $content = file_get_contents($file_path);
                    echo '<div class="preview">';
                    echo "<h3 class='preview-file-name'>$file_to_view</h3>";
                    echo '<form method="post" action="save_file.php">';
                    echo "<input type='hidden' name='file_path' value='$file_path'>";
                    echo "<textarea name='content' class='textarea'>$content</textarea>";
                    echo '<button type="submit" class="send-button">Сохранить</button>';
                    echo '</form>';
                    echo '</div>';
                }
                else {
                    echo '<p>Этот тип файла не поддерживается для просмотра.</p>';
                }
            }
            else {
                echo '<p>Файл не найден.</p>';
            }
        }
        else {
            // Просмотр содержимого директории
            $dir_to_show = $STORE_ROOT . $current_dir;
            if (is_dir($dir_to_show)) {
                display_store($current_dir);
            } else {
                echo '<p>Директория не найдена.</p>';
            }
        }
        ?>
    </div>
</div>
</body>
</html>