<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Меню</title>
    <style>
        .menu a {
            text-decoration: none;
            padding: 5px 10px;
            background-color: #f0f0f0;
            color: #333;
            border-radius: 5px;
        }
        .menu a.active {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>
<h1>Меню</h1>
<div class="menu">
    <a href="?page=about" class="<?php echo (@$_GET['page'] == 'about') ? 'active' : ''; ?>">О компании</a>
    <a href="?page=services" class="<?php echo (@$_GET['page'] == 'services') ? 'active' : ''; ?>">Услуги</a>
    <a href="?page=prices" class="<?php echo (@$_GET['page'] == 'prices') ? 'active' : ''; ?>">Прайс</a>
    <a href="?page=contacts" class="<?php echo (@$_GET['page'] == 'contacts') ? 'active' : ''; ?>">Контакты</a>
</div>

<?php
$page = @$_GET['page'];
switch ($page) {
//    case 'about':
//        echo "<h2>О компании</h2><p>Информация о компании.</p>";
//        break;
    case 'services':
        echo "<h2>Услуги</h2><p>Наши услуги.</p>";
        break;
    case 'prices':
        echo "<h2>Прайс</h2><p>Наши цены.</p>";
        break;
    case 'contacts':
        echo "<h2>Контакты</h2><p>Наши контакты.</p>";
        break;
    default:
        echo "<h2>О компании</h2><p>Информация о компании.</p>";
        break;
}
?>
</body>
</html>