<?php
require_once 'config.php';

// Получить страницу по URL
function get_page($url) {
    global $db;
    $stmt = $db->prepare("SELECT * FROM pages WHERE url = ? AND is_published = 1");
    $stmt->execute([$url]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}

// Получить меню сайта
function get_menu() {
    global $db;
    $stmt = $db->query("SELECT id, title, url FROM pages WHERE is_published = 1 AND parent_id IS NULL ORDER BY menu_order");
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}



// Поиск по сайту
function search_pages($query) {
    global $db;
    $search_term = "%$query%";
    $stmt = $db->prepare("
        SELECT id, title, url 
        FROM pages
        WHERE is_published = 1 
        AND (title LIKE ? OR content LIKE ?)
        ORDER BY title
    ");
    $stmt->execute([$search_term, $search_term]);

    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Получить случайный баннер
function get_random_banner() {
    global $db;
    $stmt = $db->query("SELECT * FROM banners WHERE is_active = 1 ORDER BY RAND() LIMIT 1");
    $banner = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($banner) {
        // Увеличиваем счетчик просмотров
        $db->prepare("UPDATE banners SET views = views + 1 WHERE id = ?")->execute([$banner['id']]);
    }

    return $banner;
}

// Регистрация клика по баннеру
function register_banner_click($banner_id) {
    global $db;
    $db->prepare("UPDATE banners SET clicks = clicks + 1 WHERE id = ?")->execute([$banner_id]);
}
// Получить карту сайта
function get_site_map() {
    global $db;
    $stmt = $db->query("
        SELECT
            p1.id, 
            p1.title, 
            p1.url, 
            p1.parent_id, 
            COALESCE(p2.title, 'Основное меню') as parent_title 
        FROM pages p1
        LEFT JOIN pages p2 ON p1.parent_id = p2.id
        WHERE p1.is_published = 1
        ORDER BY COALESCE(p1.parent_id, p1.id), p1.menu_order
    ");
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}