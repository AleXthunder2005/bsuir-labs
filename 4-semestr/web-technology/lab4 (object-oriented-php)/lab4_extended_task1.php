<?php
class Template_engine {
    private $vars = [];
    private $config = [];
    private $db = [];

    public function __construct($config_file, $db_file) {
        $this->load_config($config_file);
        $this->load_db($db_file);
    }
    private function load_config($file) {
        if (file_exists($file)) {
            $this->config = parse_ini_file($file);
        }
    }
    private function load_db($file) {
        if (file_exists($file)) {
            $this->db = json_decode(file_get_contents($file), true);
        }
    }
    public function set_var($name, $value) {
        $this->vars[$name] = $value;
    }

    // Основной метод для обработки шаблона
    public function render($template) {
        $template = $this->process_file($template);
        $template = $this->process_variables($template);
        $template = $this->process_config($template);
        $template = $this->process_db($template);
        $template = $this->process_conditions($template);
        return $template;
    }

    // Обработка файлов
    private function process_file($template) {
        return preg_replace_callback(
            '/{FILE="(.+?)"}/',
            function ($matches) {
                if (file_exists($matches[1])) {
                    return file_get_contents($matches[1]);
                }
                return '';
            },
            $template);
    }

    // Обработка переменных
    private function process_variables($template) {
        return preg_replace_callback('/{VAR="(.+?)"}/', function ($matches) {
            return isset($this->vars[$matches[1]]) ? $this->vars[$matches[1]] : '';
        }, $template);
    }

    // Обработка конфигов
    private function process_config($template) {
        return preg_replace_callback(
            '/{CONFIG="(.+?)"}/',
            function ($matches) {
                return isset($this->config[$matches[1]]) ? $this->config[$matches[1]] : '';
            },
            $template
        );
    }

    // Обработка базы данных
    private function process_db($template) {
        return preg_replace_callback(
            '/{DB="(.+?)"}/',
            function ($matches) {
                return isset($this->db[$matches[1]]) ? $this->db[$matches[1]] : '';
            },
            $template);
    }

    // Обработка условий
    private function process_conditions($template) {
        // Регулярное выражение для поиска условий
        return preg_replace_callback(
            '/{IF "(.+?)" (==|!=|<=|>=|<|>) "(.+?)"}(.*?){ELSE}?(.*?){ENDIF}/s',
            function ($matches) {
                $left = trim($matches[1]);
                $operator = $matches[2];
                $right = trim($matches[3]);

                // Определение условий
                switch ($operator) {
                    case '==':
                        $condition = $left == $right;
                        break;
                    case '!=':
                        $condition = $left != $right;
                        break;
                    case '<':
                        $condition = $left < $right;
                        break;
                    case '<=':
                        $condition = $left <= $right;
                        break;
                    case '>':
                        $condition = $left > $right;
                        break;
                    case '>=':
                        $condition = $left >= $right;
                        break;
                    default:
                        $condition = false;
                }

                // Возвращаем соответствующую часть шаблона
                return $condition ? $matches[4] : (isset($matches[5]) ? $matches[5] : '');
            }, $template);
    }
}

// Пример

$template_engine = new Template_engine('config.ini', 'database.json');
$template_engine->set_var('title', 'My Website');

$inv_number = 'INV-1001';

$template = '
<h1>{VAR="title"}</h1>

{IF "{CONFIG="user"}" == "admin"}<p>Welcome, Admin!</p>{ELSE}<p>Welcome, Guest!</p>{ENDIF}

<ul>
    <li>{DB="' . $inv_number . '"}</li>
</ul>

{FILE="footer.html"}
';

echo $template_engine->render($template);