<?php
require_once 'config.php';
require_once 'functions.php';

// Определяем текущую страницу
$page_url = isset($_GET['page']) ? $_GET['page'] : 'home';
$current_page = get_page($page_url);

// Если страница не найдена - 404
if (!$current_page) {
    header("HTTP/1.0 404 Not Found");
    $current_page = [
        'title' => '',
        'content' => '<p>Запрошенная страница не существует.</p>'
    ];
}

// Получаем меню, карту сайта и случайный баннер
$menu = get_menu();
$site_map = get_site_map();
$banner = get_random_banner();
?>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title><?= safe_output($current_page['title']) ?> | <?= SITE_TITLE ?></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        header {
            background: #f4f4f4;
            padding: 20px;
            margin-bottom: 20px;
        }
        nav ul {
            list-style: none;
            padding: 0;
            display: flex;
            gap: 15px;
        }
        nav a {
            text-decoration: none;
            color: #333;
        }
        .banner {
            margin: 20px 0;
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .banner img {
            max-width: 100%;
        }
        main {
            flex: 1;
        }
        footer {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
        .site-map {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        .site-map-column {
            display: flex;
            flex-direction: column;
        }
        .site-map a {
            color: #333;
            text-decoration: none;
            margin-bottom: 5px;
        }
        .site-map a:hover {
            text-decoration: underline;
        }
        .search-form {
            margin: 20px 0;
        }
    </style>
</head>
<body>
<header>
<!--    выводим меню-->
    <h1><?= SITE_TITLE ?></h1>
    <nav>
        <ul>
            <?php foreach ($menu as $item): ?>
                <li><a href="?page=<?= safe_output($item['url']) ?>"><?= safe_output($item['title']) ?></a></li>
            <?php endforeach; ?>
        </ul>
    </nav>
<!--    выводим поисковик-->
    <form class="search-form" action="?page=search" method="post">
        <input type="text" name="query" placeholder="Поиск по сайту">
        <button type="submit">Искать</button>
    </form>
</header>

<!--    выводим баннер-->
<main>
    <?php if ($banner): ?>
        <div class="banner">
            <a href="banner_click.php?id=<?= $banner['id'] ?>" target="_blank">
                <img src="<?= safe_output($banner['image_path']) ?>" alt="<?= safe_output($banner['title']) ?>">
            </a>
        </div>
    <?php endif; ?>

<!--    выводим содержимое страницы или результат поиска как отдельная страница-->
    <h2><?= safe_output($current_page['title']) ?></h2>
    <div class="content">
        <?php
        // Обработка специальных страниц
        if ($page_url === 'search') {
            include 'search_results.php';
        } else {
            echo $current_page['content'];
        }
        ?>
    </div>
</main>
<!--    выводим карту сайта в футере-->
<footer>
    <div class="site-map">
        <div class="site-map-column">
            <h3>Карта сайта</h3>
            <?php
            // Выводим главные страницы (те которые без родителя)
            foreach ($site_map as $item):
                if (empty($item['parent_id'])):
                    ?>
                    <a href="?page=<?= safe_output($item['url']) ?>"><?= safe_output($item['title']) ?></a>
                <?php
                endif;
            endforeach;
            ?>
        </div>

        <?php
        // Группируем страницы по родительским разделам
        $grouped_pages = [];
        foreach ($site_map as $item) {
            if (!empty($item['parent_id'])) {
                if (!isset($grouped_pages[$item['parent_id']])) {
                    $grouped_pages[$item['parent_id']] = [
                        'parent_title' => isset($item['parent_title']) ? $item['parent_title'] : 'Раздел',
                        'pages' => []
                    ];
                }
                $grouped_pages[$item['parent_id']]['pages'][] = $item;
            }
        }

        // Выводим колонки с подстраницами
        foreach ($grouped_pages as $parent_id => $group):
            ?>
            <div class="site-map-column">
                <h3><?= safe_output($group['parent_title']) ?></h3>
                <?php foreach ($group['pages'] as $page): ?>
                    <a href="?page=<?= safe_output($page['url']) ?>"><?= safe_output($page['title']) ?></a>
                <?php endforeach; ?>
            </div>
        <?php endforeach; ?>
    </div>

    <p>&copy; <?= date('Y') ?> <?= SITE_TITLE ?></p>
</footer>
</body>
</html>