<?php
// Обработка формы
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $startUrl = $_POST['url'] ?? '';
    $maxDepth = $_POST['depth'] ?? 1;
    $downloadDir = $_POST['directory'] ?? 'downloaded_images';

    try {
        // Валидация URL
        if (!filter_var($startUrl, FILTER_VALIDATE_URL)) {
            throw new Exception('Неверный URL');
        }

        // Определяем базовый URL сайта
        $parsedUrl = parse_url($startUrl);
        $baseSiteUrl = $parsedUrl['scheme'] . '://' . $parsedUrl['host'];

        // Создаем основную папку для загрузки
        if (!file_exists($downloadDir)) {
            if (!mkdir($downloadDir, 0777, true)) {
                throw new Exception('Не удалось создать директорию');
            }
        }

        // Статистика
        $stats = [
            'pages' => 0,
            'images' => 0,
            'errors' => 0,
            'categories' => []
        ];

        // Функция для получения содержимого URL
        function fetch_url($url) {
            $options = [
                'http' => [
                    'method' => 'GET',
                    'header' => implode("\r\n", [
                        'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
                        'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
                        'Accept-Language: en-US,en;q=0.5',
                    ]),
                    'ignore_errors' => true,
                    'timeout' => 15
                ]
            ];

            $context = stream_context_create($options);
            $content = @file_get_contents($url, false, $context);

            if ($content === false) {
                throw new Exception("Не удалось загрузить страницу");
            }

            return $content;
        }

        // Функция для создания папки категории
        function create_category_folder($url, $baseDir) {
            $path = parse_url($url, PHP_URL_PATH);
            // Добавляем проверку на null и пустую строку
            $parts = $path ? array_filter(explode('/', $path)) : [];
            $category = !empty($parts) ? end($parts) : '';

            // Очищаем название категории от недопустимых символов
            $category = preg_replace('/[^a-zA-Z0-9_-]/', '', $category);
            if (empty($category)) $category = 'uncategorized';

            $folder = $baseDir . '/' . $category;
            if (!file_exists($folder)) {
                mkdir($folder, 0777, true);
            }

            return $folder;
        }

        // Функция для извлечения изображений со страницы
        function extract_images($html, $url) {
            $dom = new DOMDocument();
            @$dom->loadHTML($html);
            $images = $dom->getElementsByTagName('img');
            $result = [];

            foreach ($images as $img) {
                $src = $img->getAttribute('src');
                if (!empty($src)) {
                    // Преобразуем относительные ссылки в абсолютные
                    if (strpos($src, 'http') !== 0) {
                        if ($src[0] === '/') {
                            $src = $GLOBALS['baseSiteUrl'] . $src;
                        } else {
                            $src = rtrim(dirname($url), '/') . '/' . ltrim($src, '/');
                        }
                    }
                    $result[] = $src;
                }
            }
            return array_unique($result);
        }

        // Функция для скачивания изображения
        function download_image($imageUrl, $folder, &$stats) {
            $filename = basename(parse_url($imageUrl, PHP_URL_PATH));
            if (empty($filename)) {
                $filename = 'image_' . md5($imageUrl) . '.jpg';
            }

            $savePath = $folder . '/' . $filename;

            if (!file_exists($savePath)) {
                $imageContent = fetch_url($imageUrl);

                file_put_contents($savePath, $imageContent);
                $stats['images']++;
                return true;
            }

            return false;
        }

        // Функция для извлечения ссылок со страницы
        function extract_links($html, $baseUrl) {
            $dom = new DOMDocument();
            @$dom->loadHTML($html);
            $links = $dom->getElementsByTagName('a');
            $result = [];

            foreach ($links as $link) {
                $href = $link->getAttribute('href');
                if (!empty($href)) {
                    // Пропускаем якорные ссылки и javascript
                    if ($href[0] === '#' || strpos($href, 'javascript:') === 0) continue;

                    // Преобразуем относительные ссылки в абсолютные
                    if (strpos($href, 'http') !== 0) {
                        if ($href[0] === '/') {
                            $href = $GLOBALS['baseSiteUrl'] . $href;
                        } else {
                            $href = rtrim($baseUrl, '/') . '/' . ltrim($href, '/');
                        }
                    }

                    // Фильтруем только ссылки нашего сайта
                    if (strpos($href, $GLOBALS['baseSiteUrl']) === 0) {
                        $result[] = $href;
                    }
                }
            }

            return array_unique($result);
        }

        // Рекурсивная функция обхода сайта
        function crawl_site($url, &$visited, &$stats, $depth = 0) {
            if ($depth > $GLOBALS['maxDepth'] || isset($visited[$url])) {
                return;
            }

            $visited[$url] = true;
            $stats['pages']++;

            try {
                $html = fetch_url($url);
                $categoryFolder = create_category_folder($url, $GLOBALS['downloadDir']);

                // Запоминаем категорию для отчета
                $category = basename($categoryFolder);
                if (!isset($stats['categories'][$category])) {
                    $stats['categories'][$category] = 0;
                }

                // Скачиваем изображения с этой страницы
                $images = extract_images($html, $url);
                foreach ($images as $imageUrl) {
                    try {
                        if (download_image($imageUrl, $categoryFolder, $stats)) {
                            $stats['categories'][$category]++;
                        }
                    } catch (Exception $e) {
                        $stats['errors']++;
                        error_log("Ошибка загрузки $imageUrl: " . $e->getMessage());
                    }
                }

                // Рекурсивно обходим подстраницы
                if ($depth < $GLOBALS['maxDepth']) {
                    $links = extract_links($html, $url);
                    foreach ($links as $link) {
                        crawl_site($link, $visited, $stats, $depth + 1);
                    }
                }
            } catch (Exception $e) {
                $stats['errors']++;
                error_log("Ошибка обработки $url: " . $e->getMessage());
            }
        }

        // Запускаем обход
        $visited = [];
        crawl_site($startUrl, $visited, $stats, 0);

        // Формируем сообщение с результатами
        $message = "Скачивание завершено!\n";
        $message .= "Обработано страниц: " . $stats['pages'] . "\n";
        $message .= "Скачано изображений: " . $stats['images'] . "\n";
        $message .= "Ошибок: " . $stats['errors'] . "\n";
        $message .= "Категории:\n";

        foreach ($stats['categories'] as $category => $count) {
            $message .= "- $category: $count изображений\n";
        }

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
    <title>Скачивание изображений с сайта</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], input[type="number"], select {
            width: 100%; padding: 8px; box-sizing: border-box; margin-bottom: 10px;
        }
        button {
            background: #4CAF50; color: white; border: none; padding: 10px 15px;
            cursor: pointer; font-size: 16px;
        }
        button:hover { background: #45a049; }
        .message {
            margin: 20px 0; padding: 15px; background: #f8f8f8; border: 1px solid #ddd;
            white-space: pre-line; border-radius: 4px;
        }
        .container { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        h1 { color: #333; text-align: center; }
    </style>
</head>
<body>
<div class="container">
    <h1>Скачивание изображений с сайта</h1>

    <form method="post">
        <div class="form-group">
            <label for="url">URL сайта:</label>
            <input type="text" id="url" name="url" placeholder="https://example.com" required>
        </div>

        <div class="form-group">
            <label for="depth">Глубина обхода (1-3):</label>
            <input type="number" id="depth" name="depth" min="1" max="3" value="1" required>
        </div>

        <div class="form-group">
            <label for="directory">Папка для сохранения:</label>
            <input type="text" id="directory" name="directory" value="downloaded_images" required>
        </div>

        <button type="submit">Начать скачивание</button>
    </form>

    <?php if (!empty($message)): ?>
        <div class="message"><?php echo htmlspecialchars($message); ?></div>
    <?php endif; ?>
</div>
</body>
</html>