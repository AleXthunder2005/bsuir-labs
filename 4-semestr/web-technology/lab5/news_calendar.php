<?php
class news_calendar {
    private $db;
    private $current_year;
    private $current_month;

    public function __construct() {
        $this->connect_db();
        $this->set_current_date();
    }

    private function connect_db() {
        $this->db = new mysqli('localhost', 'root', 'Fasad123698745)', 'news_calendar');
        if ($this->db->connect_error) {
            die("Ошибка соединения: " . $this->db->connect_error);
        }
    }

    private function set_current_date() {
        $this->current_year = isset($_GET['year']) ? (int)$_GET['year'] : date('Y');
        $this->current_month = isset($_GET['month']) ? (int)$_GET['month'] : date('m');

        if ($this->current_month > 12) {
            $this->current_month = 1;
            $this->current_year++;
        } elseif ($this->current_month < 1) {
            $this->current_month = 12;
            $this->current_year--;
        }
    }

    public function get_dates_with_news() {
        $result = $this->db->query(
            "SELECT DISTINCT DATE(publish_date) as news_date 
             FROM news 
             WHERE YEAR(publish_date) = $this->current_year 
             AND MONTH(publish_date) = $this->current_month
             ORDER BY news_date"
        );

        $dates = [];
        while ($row = $result->fetch_assoc()) {
            $dates[] = $row['news_date'];
        }
        return $dates;
    }

    public function render_calendar() {
        $active_dates = array_flip($this->get_dates_with_news());
        $days_in_month = cal_days_in_month(CAL_GREGORIAN, $this->current_month, $this->current_year);
        $first_day = date('N', strtotime("$this->current_year-$this->current_month-01"));

        // Навигация по месяцам
        $prev_month = $this->current_month - 1 < 1 ? 12 : $this->current_month - 1;
        $prev_year = $prev_month == 12 ? $this->current_year - 1 : $this->current_year;
        $next_month = $this->current_month + 1 > 12 ? 1 : $this->current_month + 1;
        $next_year = $next_month == 1 ? $this->current_year + 1 : $this->current_year;

        echo '<div class="calendar_nav">
                <a href="?month='.$prev_month.'&year='.$prev_year.'">←</a>
                <h2>'.date('F Y', strtotime("$this->current_year-$this->current_month-01")).'</h2>
                <a href="?month='.$next_month.'&year='.$next_year.'">→</a>
              </div>';

        echo '<table class="calendar"><tr><th>Пн</th><th>Вт</th><th>Ср</th><th>Чт</th><th>Пт</th><th>Сб</th><th>Вс</th></tr><tr>';

        // Пустые ячейки для первого дня недели
        for ($i = 1; $i < $first_day; $i++) {
            echo '<td></td>';
        }

        // Дни месяца
        for ($day = 1; $day <= $days_in_month; $day++) {
            $date = sprintf('%04d-%02d-%02d', $this->current_year, $this->current_month, $day);

            if (isset($active_dates[$date])) {
                echo '<td class="has_news"><a href="news.php?date='.$date.'">'.$day.'</a></td>';
            } else {
                echo '<td>'.$day.'</td>';
            }

            if (($day + $first_day - 1) % 7 == 0) {
                echo '</tr><tr>';
            }
        }

        echo '</tr></table>';
    }

    public function render_all_news() {
        $result = $this->db->query(
            "SELECT n.news_id, n.title, n.publish_date, 
                    a.full_name as author, a.email
             FROM news n
             LEFT JOIN authors a ON n.author_id = a.author_id
             ORDER BY n.publish_date DESC"
        );

        echo '<h2>Все новости</h2>';
        echo '<table class="news_list">';
        echo '<tr>
                <th>ID</th>
                <th>Заголовок</th>
                <th>Дата</th>
                <th>Автор</th>
                <th>Email</th>
              </tr>';

        while ($row = $result->fetch_assoc()) {
            echo '<tr>
                    <td>'.$row['news_id'].'</td>
                    <td>'.$row['title'].'</td>
                    <td>'.date('d.m.Y', strtotime($row['publish_date'])).'</td>
                    <td>'.$row['author'].'</td>
                    <td>'.$row['email'].'</td>
                  </tr>';
        }

        echo '</table>';
    }

    public function __destruct() {
        $this->db->close();
    }
}

$calendar = new news_calendar();
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Календарь новостей</title>
    <style>
        body {
            font-family: Arial;
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        .calendar_nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .calendar_nav a {
            padding: 5px 15px;
            background: #f0f0f0;
            border-radius: 4px;
            text-decoration: none;
            color: #333;
        }
        .calendar {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        .calendar th, .calendar td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .calendar th {
            background-color: #f5f5f5;
        }
        .has_news a {
            color: red;
            font-weight: bold;
            text-decoration: none;
        }
        .has_news a:hover {
            text-decoration: underline;
        }
        .news_list {
            width: 100%;
            border-collapse: collapse;
        }
        .news_list th, .news_list td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .news_list th {
            background-color: #f5f5f5;
        }
        .news_list tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
<h1>Календарь новостей</h1>
<?php
$calendar->render_calendar();
$calendar->render_all_news();
?>
</body>
</html>