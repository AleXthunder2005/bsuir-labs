<?php
$db = new mysqli('localhost', 'root', 'Fasad123698745)', 'news_calendar');
$date = $_GET['date'];

$result = $db->query(
    "SELECT * FROM news 
     WHERE DATE(publish_date) = '$date' 
     ORDER BY publish_date"
);
?>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>News for <?= $date ?></title>
        <style>
            body { font-family: Arial; max-width: 800px; margin: 0 auto; padding: 20px; }
            .news-item { margin-bottom: 20px; padding-bottom: 10px; border-bottom: 1px solid #eee; }
        </style>
    </head>
    <body>
    <h1>News for <?= $date ?></h1>
    <a href="news_calendar.php">← Back</a>

    <?php if ($result->num_rows === 0): ?>
        <p>No news for this date</p>
    <?php else: ?>
        <?php while ($row = $result->fetch_assoc()): ?>
            <div class="news-item">
                <h2><?= $row['title'] ?></h2>
                <p><?= $row['content'] ?></p>
                <small><?= $row['publish_date'] ?></small>
            </div>
        <?php endwhile; ?>
    <?php endif; ?>
    </body>
    </html>
<?php $db->close(); ?>