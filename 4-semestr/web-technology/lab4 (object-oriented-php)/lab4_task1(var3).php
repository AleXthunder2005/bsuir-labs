<?php
class Logger {
    private $output_to_file; // true - в файл; false - на экран
    private $log_file_name; //имя файла

    public function __construct($output_to_file = false, $log_file_name = 'log.txt') {
        $this->output_to_file = $output_to_file;
        $this->log_file_name = $log_file_name;
    }
    public function log($message) {
        // Добавляем дату и время к сообщению
        $log_time = date('Y-m-d H:i:s');
        $formatted_message = "[$log_time] $message" . PHP_EOL;

        if ($this->output_to_file) {
            // Записываем в файл
            if (!file_put_contents($this->log_file_name, $formatted_message, FILE_APPEND))
            {
                echo 'Не удалось записать в файл ' . $this->log_file_name;
            }
        } else {
            // Выводим на экран
            echo $formatted_message;
        }
    }
}

//примеры
$screenLogger = new Logger();
$screenLogger->log("сообщение на экран");

$fileLogger = new Logger(true, 'application.log');
$fileLogger->log("сообщение в файл application.log");
