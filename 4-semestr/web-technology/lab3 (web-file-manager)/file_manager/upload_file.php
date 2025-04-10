<?php
require_once __DIR__ . '/config.php';
$STORE_ROOT = STORE_ROOT;

$relative_path = $_POST['upload_to_path'] ?? '';
$file_path = $STORE_ROOT . DIRECTORY_SEPARATOR . $relative_path;

// Создаем целевую директорию, если ее нет
if (!file_exists($file_path)) {
    mkdir($file_path, 0777, true);
}

// Обработка загружаемых файлов
if (!empty($_FILES['uploaded_files']['name'][0])) {
    $uploaded_files = $_FILES['uploaded_files'];


    // Если загружен один файл - преобразуем в массив для единообразной обработки
    if (!is_array($uploaded_files['name'])) {
        $uploaded_files = [
            'name' => [$uploaded_files['name']],
            'tmp_name' => [$uploaded_files['tmp_name']],
            'error' => [$uploaded_files['error']]
        ];
    }

    // Обрабатываем каждый файл
    for ($i = 0; $i < count($uploaded_files['name']); $i++) {
        $filename = $uploaded_files['name'][$i];
        $tmp_name = $uploaded_files['tmp_name'][$i];
        $error = $uploaded_files['error'][$i];

        if ($error === UPLOAD_ERR_OK) {
            $destination = $file_path . DIRECTORY_SEPARATOR . $filename;

            if (move_uploaded_file($tmp_name, $destination)) {
                // Файл успешно загружен
            } else {
                // Ошибка перемещения файла
            }
        } else {
            // Обработка ошибок загрузки
            switch ($error) {
                case UPLOAD_ERR_INI_SIZE:
                case UPLOAD_ERR_FORM_SIZE:
                    // Файл слишком большой
                    break;
                case UPLOAD_ERR_PARTIAL:
                    // Файл загружен частично
                    break;
                case UPLOAD_ERR_NO_FILE:
                    // Файл не был загружен
                    break;
                default:
                    // Неизвестная ошибка
            }
        }
    }
}

// Возвращаемся на предыдущую страницу
header("Location: " . $_SERVER['HTTP_REFERER']);
exit();