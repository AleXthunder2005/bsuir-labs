<!--display_store.php-->
<?php
require_once __DIR__ . '/config.php';
$STORE_ROOT = STORE_ROOT;
function read_directory($directory)
{
    $directory = STORE_ROOT . '/' . $directory;
    $result = [];
    $files = scandir($directory);

    foreach ($files as $file) {
        $filepath = $directory . DIRECTORY_SEPARATOR . $file;

        if (is_file($filepath)) {
            $filetime = filectime($filepath);
            $filesize = filesize($filepath);

            $result[] = [
                'type' => 'file',
                'name' => $file,
                'time' => !empty($filetime) ? date('d-m-Y H:i:s', $filetime) : '-',
                'size' => $filesize,
            ];
        } elseif (is_dir($filepath) && $file !== '.' && $file !== '..') {
            $result[] = [
                'type' => 'directory',
                'name' => $file,
            ];
        }
    }

    return $result;
}

function display_directory($content, $current_dir)
{
    if (empty($content)) {
        echo "<p>Файлы не найдены.</p>";
        return;
    }

    echo "<ul>";
    foreach ($content as $item) {
        if ($item['type'] === 'file') {
            $size = round($item['size'] / 1024, 2) . ' KB';
            echo "<li class='file'>📄 <a class='link' href='?dir=" . urlencode($current_dir) . "&file=" . urlencode($item['name']) . "'>{$item['name']}</a> <span class='file-info'>({$size}, {$item['time']})</span></li>";
        } elseif ($item['type'] === 'directory') {
            $new_dir = $current_dir . '/' . $item['name'];
            echo "<li class='directory'>📁 <a class='link' href='?dir=" . urlencode($new_dir) . "'>{$item['name']}</a></li>";
        }
    }
    echo "</ul>";
}

function display_store($directory)
{
    $directory_content = read_directory($directory);
      display_directory($directory_content, $directory);
}