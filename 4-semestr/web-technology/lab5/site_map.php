<?php
$site_map = get_site_map();
?>
<h3>Карта сайта</h3>
<div class="site-map">
    <?php foreach ($site_map as $item): ?>
        <div>
            <?php if ($item['parent_title']): ?>
                <small><?= safe_output($item['parent_title']) ?> →</small>
            <?php endif; ?>
            <a href="?page=<?= safe_output($item['url']) ?>"><?= safe_output($item['title']) ?></a>
        </div>
    <?php endforeach; ?>
</div>