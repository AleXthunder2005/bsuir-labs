<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($_POST['query'])) {
    $search_query = trim($_POST['query']);
    $results = search_pages($search_query);

    echo "<h3>Результаты поиска для: ".safe_output($search_query)."</h3>";

    if (count($results) > 0) {
        echo "<ul>";
        foreach ($results as $result) {
            echo "<li><a href='?page=".safe_output($result['url'])."'>"
                .safe_output($result['title'])."</a></li>";
        }
        echo "</ul>";
    } else {
        echo "<p>Ничего не найдено.</p>";
    }
} else {
    echo "<p>Введите поисковый запрос в форму выше.</p>";
}
