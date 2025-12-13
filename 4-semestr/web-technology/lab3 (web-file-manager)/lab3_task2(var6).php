<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Поиск файлов</title>
    <style>
        * {margin: 0; padding: 0; box-sizing: border-box;}
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 800px;
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
    </style>
</head>
<body>
<div class="container">
    <h1>Поиск файлов</h1>

    <form method="post" action="">
        <div class="input-group">
            <label for="directory">Каталог:</label>
            <input class="input-element" type="text" id="directory" name="directory" required>
        </div>

        <div class="input-group">
            <label for="pattern">Сочетание символов:</label>
            <input class="input-element" type="text" id="pattern" name="pattern">
        </div>

        <div class="input-group">
            <label for="start-date">Дата от:</label>
            <input class="input-element" type="date" id="start-date" name="start_date">
        </div>

        <div class="input-group">
            <label for="end-date">Дата до:</label>
            <input class="input-element" type="date" id="end-date" name="end_date">
        </div>

        <button type="submit" class="send-button">Искать</button>
    </form>

    <div class="results">
        <?php
        function find_files_by_criteria($directory, $pattern, $startDate, $endDate) {
            $result = [];
            $files = scandir($directory);

            foreach ($files as $file) {
                $filepath = $directory . DIRECTORY_SEPARATOR . $file;

                if (is_file($filepath)) {
                    $filetime = filectime($filepath);

                    if ($filetime === false) {
                        continue;
                    }

                    if (!empty($pattern) && strpos($file, $pattern) === false) {
                        continue;
                    }

                    if ($filetime < $startDate || $filetime > $endDate) {
                        continue;
                    }

                    $result[] = [
                        'type' => 'file',
                        'name' => $file,
                        'time' => date('d-m-Y H:i:s', $filetime),
                    ];
                } elseif (is_dir($filepath) && $file !== '.' && $file !== '..') {
                    $subdir_content = find_files_by_criteria($filepath, $pattern, $startDate, $endDate);
                    if (!empty($subdir_content)) {
                        $result[] = [
                            'type' => 'directory',
                            'name' => $file,
                            'content' => $subdir_content,
                        ];
                    }
                }
            }

            return $result;
        }

        function display_directory($content) {
            if (empty($content)) {
                echo "<p>Файлы не найдены.</p>";
                return;
            }

            echo "<ul>";
            foreach ($content as $item) {
                if ($item['type'] === 'file') {
                    echo "<li class='file'>📄 {$item['name']} <span class='file-info'>({$item['time']})</span></li>";
                }
                elseif ($item['type'] === 'directory') {
                    echo "<li class='directory'>📁 {$item['name']}";
                    if (!empty($item['content'])) {
                        display_directory($item['content']);
                    }
                    echo "</li>";
                }
            }
            echo "</ul>";
        }

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (empty($_POST['directory'])) {
                die("Не указана директория!");
            }

            $directory = trim($_POST['directory']);
            $pattern = !empty($_POST['pattern']) ? trim($_POST['pattern']) : '';
            $startDate = !empty($_POST['start_date']) ? strtotime($_POST['start_date']) : 0;
            $endDate = !empty($_POST['end_date']) ? strtotime($_POST['end_date']) : time();

            if (!file_exists($directory) || !is_dir($directory)) {
                echo "<p>Директория не найдена или не является папкой.</p>";
            } else {
                $directory_content = find_files_by_criteria($directory, $pattern, $startDate, $endDate);
                display_directory($directory_content);
            }
        }
        ?>
    </div>
</div>
</body>
</html>