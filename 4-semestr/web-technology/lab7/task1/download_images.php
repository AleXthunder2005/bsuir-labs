<?php
function fetch_url($url) {
    $options = [
        'http' => [
            'method' => 'GET',
            'header' => implode("\r\n", [
                'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
                'Accept: image/webp,image/apng,image/*,*/*;q=0.8',
                'Accept-Language: en-US,en;q=0.9',
            ]),
            'ignore_errors' => true
        ]
    ];

    $context = stream_context_create($options);
    $content = file_get_contents($url, false, $context);

//     Проверяем кодировку ответа
    foreach ($http_response_header as $header) {
        if (strpos($header, 'Content-Encoding:') !== false) {
            if (strpos($header, 'gzip') !== false) {
                $content = gzdecode($content);
            } elseif (strpos($header, 'deflate') !== false) {
                $content = gzinflate($content); // Для deflate
            }
            break;
        }
    }

    return $content;
}

// Функция для извлечения всех URL изображений из HTML
function extract_image_urls($html, $baseUrl) {
    $dom = new DOMDocument();
    @$dom->loadHTML($html);
    $images = $dom->getElementsByTagName('img');
    $imageUrls = [];

    // Собираем все URL изображений
    foreach ($images as $img) {
        $src = $img->getAttribute('src');
        if (!empty($src)) {
            $imageUrls[] = $src;
        }
    }

    // Удаляем дубликаты
    $imageUrls = array_unique($imageUrls);

    // Обрабатываем каждый URL
    $result = [];
    $parsedBase = parse_url($baseUrl);
    $base = $parsedBase['scheme'] . '://' . $parsedBase['host'];

    // Получаем базовый путь без имени файла
    $basePath = isset($parsedBase['path']) ? $parsedBase['path'] : '';
    if (substr($basePath, -1) !== '/') {
        $basePath = dirname($basePath) . '/';
    }

    foreach ($imageUrls as $url) {
        try {
            // Обработка протокол-относительных URL (//example.com/image.jpg)
            if (strpos($url, '//') === 0) {
                $result[] = $parsedBase['scheme'] . ':' . $url;
                continue;
            }

            // Абсолютные URL оставляем как есть
            if (strpos($url, 'http') === 0) {
                $result[] = $url;
                continue;
            }

            // Обработка относительных URL
            $path = $url;

            // Удаляем ./ в начале
            $path = preg_replace('@^\./@', '', $path);

            // Обрабатываем относительные пути с ../
            if (strpos($path, '../') === 0) {
                $baseParts = explode('/', trim($basePath, '/'));
                $pathParts = explode('/', $path);

                foreach ($pathParts as $part) {
                    if ($part === '..') {
                        array_pop($baseParts);
                    } else if ($part !== '.') {
                        $baseParts[] = $part;
                    }
                }

                $result[] = $base . '/' . implode('/', $baseParts);
            } else {
                // Простые относительные пути
                $result[] = $base . '/' . ltrim($basePath . $path, '/');
            }
        } catch (Exception $e) {
            error_log("Failed to process image URL: $url - " . $e->getMessage());
            continue;
        }
    }

    return array_values(array_unique($result));
}

// Проверяем, была ли отправлена форма
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $url = isset($_POST['url']) ? $_POST['url'] : '';
    $directory = isset($_POST['directory']) ? $_POST['directory'] : 'downloaded_images';

    try {
        // Валидация URL
        if (!filter_var($url, FILTER_VALIDATE_URL)) {
            throw new Exception('Неверный URL');
        }

        // Создаем директорию, если ее нет
        if (!file_exists($directory)) {
            if (!mkdir($directory, 0777, true)) {
                throw new Exception('Не удалось создать директорию');
            }
        }

        // Получаем содержимое страницы с обработкой ошибок
        $html = fetch_url($url);

        // Извлекаем все URL изображений
        $imageUrls = extract_image_urls($html, $url);

        $downloaded = 0;
        $errors = 0;

        foreach ($imageUrls as $imageUrl) {
            try {
                // Получаем имя файла
                $filename = basename(parse_url($imageUrl, PHP_URL_PATH));
                if (empty($filename)) {
                    $filename = 'image_' . uniqid() . '.jpg';
                }

                // Полный путь для сохранения
                $savePath = $directory . '/' . $filename;

                // Пытаемся скачать изображение
                $imageContent = fetch_url($imageUrl);
                if (file_put_contents($savePath, $imageContent)) {
                    $downloaded++;
                } else {
                    throw new Exception("Не удалось сохранить изображение: $imageUrl");
                }
            } catch (Exception $e) {
                error_log($e->getMessage());
                $errors++;
            }
        }

        $message = "Скачивание завершено. Успешно: $downloaded, ошибок: $errors.";
    } catch (Exception $e) {
        $message = "Ошибка: " . $e->getMessage();
    }
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Скачивание изображений с веб-страницы</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"] { width: 100%; padding: 8px; box-sizing: border-box; }
        button { background: #4CAF50; color: white; border: none; padding: 10px 15px; cursor: pointer; }
        button:hover { background: #45a049; }
        .message { margin: 20px 0; padding: 10px; background: #f8f8f8; border: 1px solid #ddd; }
    </style>
</head>
<body>
<h1>Скачивание изображений с веб-страницы</h1>

<form method="post">
    <div class="form-group">
        <label for="url">URL страницы:</label>
        <input type="text" id="url" name="url" placeholder="https://example.com" required>
    </div>

    <div class="form-group">
        <label for="directory">Директория для сохранения:</label>
        <input type="text" id="directory" name="directory" placeholder="downloaded_images" value="downloaded_images">
    </div>

    <button type="submit">Скачать изображения</button>
</form>

<?php if (!empty($message)): ?>
    <div class="message"><?php echo htmlspecialchars($message); ?></div>
<?php endif; ?>
</body>
</html>