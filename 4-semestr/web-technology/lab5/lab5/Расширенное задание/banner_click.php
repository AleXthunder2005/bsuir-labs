<?php
require_once 'config.php';
require_once 'functions.php';

if (isset($_GET['id'])) {
    $banner_id = (int)$_GET['id'];
    register_banner_click($banner_id);

    // Получаем URL баннера для редиректа
    $stmt = $db->prepare("SELECT link_url FROM banners WHERE id = ?");
    $stmt->execute([$banner_id]);
    $banner = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($banner) {
        header("Location: ".$banner['link_url']);
        exit;
    }
}

// Если что-то пошло не так
header("Location: ".SITE_URL);

