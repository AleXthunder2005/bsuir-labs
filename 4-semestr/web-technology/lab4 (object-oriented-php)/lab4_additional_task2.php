<?php
class File_system_object {
    private $name; //имя файла
    private $size; // размер в байтах
    private $type; // 'file' или 'directory'

    public function __construct($name, $size, $type) {
        $this->name = $name;
        $this->size = $size;
        $this->type = $type;
    }

    public function get_name() {
        return $this->name;
    }
    public function get_type() {
        return $this->type;
    }
    public function get_size($unit_of_measure = 'B') {
        $divisors = [
            'B' => 1,
            'KB' => 1024,
            'MB' => 1024 * 1024,
            'GB' => 1024 * 1024 * 1024,
            'TB' => 1024 * 1024 * 1024 * 1024
        ];

        if (!isset($divisors[$unit_of_measure])) {
            throw new InvalidArgumentException("Неизвестная единица измерения: $unit_of_measure");
        }

        return $this->size / $divisors[$unit_of_measure];
    }

    public static function create_from_path($path) :self {
        if (!file_exists($path)) {
            throw new InvalidArgumentException("Файл или директория не существует: $path");
        }

        $name = basename($path);
        $size = is_dir($path) ? 0 : filesize($path);
        $type = is_dir($path) ? 'directory' : 'file';

        return new self($name, $size, $type);
    }
}

// Чтение текущего каталога и вывод файлов с размерами в MB
$current_dir = __DIR__;
$items = scandir($current_dir);

foreach ($items as $item) {
    if ($item === '.' || $item === '..') continue;

    $path = $current_dir . DIRECTORY_SEPARATOR . $item;
    try {
        $file_system_obj = File_system_object::create_from_path($path);

        if ($file_system_obj->get_type() === 'file') {
            $size_kb = round($file_system_obj->get_size('KB'), 2);
            echo "Файл: " . $file_system_obj->get_name() . ", Размер: " . $size_kb . " KB" . "<br>";
        }
    } catch (Exception $e) {
        echo "Ошибка обработки $item: " . $e->getMessage() . "<br>";
    }
}