<?php
session_start();

// Проверка авторизации
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit;
}

$userName = htmlspecialchars($_SESSION['name']);
$userDir = 'store/' . $_SESSION['user_id'];
$currentDir = $userDir . '/';

// Обработка действий
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Загрузка файла
    if (isset($_FILES['file'])) {
        $uploadFile = $currentDir . basename($_FILES['file']['name']);
        if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadFile)) {
            $message = "Файл успешно загружен.";
        } else {
            $message = "Ошибка загрузки файла.";
        }
    }

//    // Создание папки
//    if (isset($_POST['create_dir']) && !empty($_POST['dir_name'])) {
//        $newDir = $currentDir . $_POST['dir_name'];
//        if (!file_exists($newDir)) {
//            mkdir($newDir, 0755);
//            $message = "Папка создана.";
//        } else {
//            $message = "Папка уже существует.";
//        }
//    }

    // Удаление файла/папки
    if (isset($_POST['delete'])) {
        $itemToDelete = $currentDir . $_POST['delete'];
        unlink($itemToDelete);
        $message = "Файл удален.";
    }
}

// Навигация по папкам
if (isset($_GET['dir'])) {
    $requestedDir = realpath($userDir . '/' . $_GET['dir']);
    // Проверяем, что запрошенная папка находится внутри пользовательской директории
    if (strpos($requestedDir, realpath($userDir)) === 0) {
        $currentDir = $requestedDir . '/';
    }
}

// Получаем список файлов и папок
$items = scandir($currentDir);
$items = array_diff($items, ['.', '..']);
?>

    <!DOCTYPE html>
    <html>
    <head>
        <title>Файловый менеджер - <?= $userName ?></title>
        <style>
            body {
                font-family: Arial, sans-serif;
                line-height: 1.6;
                margin: 0;
                padding: 20px;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h1 {
                color: #333;
                border-bottom: 1px solid #eee;
                padding-bottom: 10px;
            }
            .user-info {
                background: #f0f8ff;
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 20px;
            }
            .message {
                padding: 10px;
                margin: 10px 0;
                border-radius: 5px;
            }
            .success {
                background: #dff0d8;
                color: #3c763d;
            }
            .error {
                background: #f2dede;
                color: #a94442;
            }
            .breadcrumbs {
                padding: 8px 15px;
                margin-bottom: 20px;
                list-style: none;
                background-color: #f5f5f5;
                border-radius: 4px;
            }
            .breadcrumbs a {
                color: #337ab7;
                text-decoration: none;
            }
            .breadcrumbs > li {
                display: inline-block;
            }
            .breadcrumbs > li + li:before {
                padding: 0 5px;
                color: #ccc;
                content: "/\00a0";
            }
            .file-actions {
                margin: 20px 0;
                padding: 15px;
                background: #f9f9f9;
                border-radius: 5px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            table, th, td {
                border: 1px solid #ddd;
            }
            th, td {
                padding: 12px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            tr:hover {
                background-color: #f1f1f1;
            }
            .btn {
                display: inline-block;
                padding: 6px 12px;
                margin-bottom: 0;
                font-size: 14px;
                font-weight: 400;
                line-height: 1.42857143;
                text-align: center;
                white-space: nowrap;
                vertical-align: middle;
                cursor: pointer;
                background-image: none;
                border: 1px solid transparent;
                border-radius: 4px;
                text-decoration: none;
            }
            .btn-primary {
                color: #fff;
                background-color: #337ab7;
                border-color: #2e6da4;
            }
            .btn-danger {
                color: #fff;
                background-color: #d9534f;
                border-color: #d43f3a;
            }
        </style>
    </head>
    <body>
    <div class="container">
        <div class="user-info">
            <h1>Файловый менеджер</h1>
            <p>Добро пожаловать, <strong><?= $userName ?></strong>! <a href="logout.php" class="btn btn-danger">Выйти</a></p>
        </div>

        <?php if (isset($message)): ?>
            <div class="message <?= strpos($message, 'Ошибка') !== false ? 'error' : 'success' ?>">
                <?= htmlspecialchars($message) ?>
            </div>
        <?php endif; ?>

        <div class="file-actions">
            <h3>Загрузить файл</h3>
            <form method="post" enctype="multipart/form-data">
                <input type="file" name="file">
                <button type="submit" class="btn btn-primary">Загрузить</button>
            </form>
        </div>

        <h2>Содержимое папки: <?= htmlspecialchars(str_replace($userDir, '', $currentDir)) ?: '/' ?></h2>

        <?php if (empty($items)): ?>
            <p>Папка пуста</p>
        <?php else: ?>
            <table>
                <thead>
                <tr>
                    <th>Имя</th>
                    <th>Тип</th>
                    <th>Размер</th>
                    <th>Действия</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($items as $item): ?>
                    <?php
                    $itemPath = $currentDir . $item;
                    $isDir = is_dir($itemPath);
                    $size = $isDir ? '-' : formatSizeUnits(filesize($itemPath));
                    ?>
                    <tr>
                        <td>
                            <?php if ($isDir): ?>
                                <a href="?dir=<?= urlencode(str_replace($userDir . '/', '', $itemPath)) ?>">
                                    📁 <?= htmlspecialchars($item) ?>
                                </a>
                            <?php else: ?>
                                📄 <?= htmlspecialchars($item) ?>
                            <?php endif; ?>
                        </td>
                        <td><?= $isDir ? 'Папка' : 'Файл' ?></td>
                        <td><?= $size ?></td>
                        <td>
                            <?php if (!$isDir): ?>
                                <a href="<?= htmlspecialchars($itemPath) ?>" download class="btn btn-primary">Скачать</a>
                            <?php endif; ?>
                            <form method="post" style="display: inline;">
                                <input type="hidden" name="delete" value="<?= htmlspecialchars($item) ?>">
                                <button type="submit" onclick="return confirm('Вы уверены?')" class="btn btn-danger">Удалить</button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        <?php endif; ?>
    </div>
    </body>
    </html>

<?php
// Функция для форматирования размера файла
function formatSizeUnits($bytes) {
    if ($bytes >= 1073741824) {
        $bytes = number_format($bytes / 1073741824, 2) . ' GB';
    } elseif ($bytes >= 1048576) {
        $bytes = number_format($bytes / 1048576, 2) . ' MB';
    } elseif ($bytes >= 1024) {
        $bytes = number_format($bytes / 1024, 2) . ' KB';
    } elseif ($bytes > 1) {
        $bytes = $bytes . ' bytes';
    } elseif ($bytes == 1) {
        $bytes = $bytes . ' byte';
    } else {
        $bytes = '0 bytes';
    }
    return $bytes;
}
?>