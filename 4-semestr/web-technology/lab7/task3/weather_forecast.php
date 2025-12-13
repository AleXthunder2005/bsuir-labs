<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Агрегатор прогноза погоды</title>
    <meta charset="utf-8">
    <style>
        body {
            font-family: sans-serif;
        }
        .container {
            width: 80%;
            margin: 0 auto;
        }
        .weather-site {
            margin-bottom: 10px;
            border: 1px solid #ccc;
            padding: 10px;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .average-forecast {
            font-weight: bold;
            font-size: 1.2em;
            margin-top: 20px;
            padding: 10px;
            background-color: #e6f7ff;
            border-radius: 5px;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
        .refresh-btn {
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Агрегатор прогноза погоды для Минска</h1>

    <form method="post">
        <button type="submit" class="refresh-btn">Обновить прогноз</button>
    </form>

    <?php
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $city = 'minsk';
        function getWeatherData($url) {
            $options = [
                'http' => [
                    'method' => 'GET',
                    'header' => "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36\r\n"
                ]
            ];
            $context = stream_context_create($options);

            $response = @file_get_contents($url, false, $context);

            if ($response === false) {
                return null;
            }
            return json_decode($response, true);
        }

        // Получение прогнозов с разных API
        $forecasts = [];
        $errors = [];
        $lat = 53.893009;
        $lon = 27.567444;

        // 1. OpenWeatherMap
        try {
            $api_key = '376a23312b79065ce95254d0dd1d8c1b';
            $url = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&lang=ru&appid=$api_key";
            $data = getWeatherData($url);

            if ($data && isset($data['main']['temp'])) {
                $forecasts[] = [
                    'site_name' => 'OpenWeatherMap',
                    'temperature' => $data['main']['temp'],
                    'condition' => isset($data['weather'][0]['description']) ? $data['weather'][0]['description'] : 'нет данных'
                ];
            } else {
                $errors[] = 'OpenWeatherMap: не удалось получить данные';
            }
        } catch (Exception $e) {
            $errors[] = 'OpenWeatherMap: ошибка запроса';
        }

        // 2. WeatherAPI
        try {
            $api_key = '57c091e30e774bce929141207250106';
            $url = "http://api.weatherapi.com/v1/forecast.json?key=$api_key&q=$city&days=1&lang=ru";
            $data = getWeatherData($url);

            if ($data && isset($data['forecast']['forecastday'][0]['day']['avgtemp_c'])) {
                $forecasts[] = [
                    'site_name' => 'WeatherAPI',
                    'temperature' => $data['forecast']['forecastday'][0]['day']['avgtemp_c'],
                    'condition' => isset($data['forecast']['forecastday'][0]['day']['condition']['text']) ? $data['forecast']['forecastday'][0]['day']['condition']['text'] : 'нет данных'
                ];
            } else {
                $errors[] = 'WeatherAPI: не удалось получить данные';
            }
        } catch (Exception $e) {
            $errors[] = 'WeatherAPI: ошибка запроса';
        }

        // 3. VisualCrossing
        try {
            $api_key = 'KRJVSQ9T22P76APLF8UMQ7SJJ';
            $url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$city/tomorrow?unitGroup=metric&include=days&key=$api_key&contentType=json&lang=ru";
            $data = getWeatherData($url);

            if ($data && isset($data['days'][0]['temp'])) {
                $forecasts[] = [
                    'site_name' => 'VisualCrossing',
                    'temperature' => $data['days'][0]['temp'],
                    'condition' => isset($data['days'][0]['conditions']) ? $data['days'][0]['conditions'] : 'нет данных'
                ];
            } else {
                $errors[] = 'VisualCrossing: не удалось получить данные';
            }
        } catch (Exception $e) {
            $errors[] = 'VisualCrossing: ошибка запроса';
        }

        // 4. Open-Meteo
        try {
            $url = "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true";
            $data = getWeatherData($url);

            if ($data && isset($data['current_weather']['temperature'])) {
                $forecasts[] = [
                    'site_name' => 'Open-Meteo',
                    'temperature' => $data['current_weather']['temperature'],
                    'condition' => $data['current_weather']['weathercode'] ? 'Код погоды: ' . $data['current_weather']['weathercode'] : 'нет данных'
                ];
            } else {
                $errors[] = 'Open-Meteo: не удалось получить данные';
            }
        } catch (Exception $e) {
            $errors[] = 'Open-Meteo: ошибка запроса';
        }

        // 5. AccuWeather API для Минска
        $location_key = "28580";
        try {
            $api_key = '4QyGGLsRYrHvOTRGFg8EZEYmWlmmfmtd';
            $weather_url = "http://dataservice.accuweather.com/currentconditions/v1/$location_key?apikey=$api_key&language=ru-ru&details=true";
            $weather_data = getWeatherData($weather_url);

            if ($weather_data && isset($weather_data[0]['Temperature']['Metric']['Value'])) {
                $current = $weather_data[0];
                $forecasts[] = [
                    'site_name' => 'AccuWeather',
                    'temperature' => $current['Temperature']['Metric']['Value'],
                    'condition' => $current['WeatherText'] ?? 'Нет данных',
                ];
            } else {
                $errors[] = 'AccuWeather: не удалось получить данные о погоде';
            }
        } catch (Exception $e) {
            $errors[] = 'AccuWeather: ошибка запроса';
        }

        // Выводим результаты
        echo "<h2>Прогнозы для Минска:</h2>";

        // Выводим ошибки, если есть
        if (!empty($errors)) {
            foreach ($errors as $error) {
                echo "<div class='error'>$error</div>";
            }
        }

        // Выводим прогнозы
        $total_temperature = 0;
        $num_forecasts = count($forecasts);

        foreach ($forecasts as $forecast) {
            echo "<div class='weather-site'>";
            echo "<strong>" . htmlspecialchars($forecast['site_name']) . ":</strong><br>";
            echo "Температура: " . htmlspecialchars($forecast['temperature']) . "°C<br>";
            echo "Состояние: " . htmlspecialchars($forecast['condition']);
            echo "</div>";

            $total_temperature += $forecast['temperature'];
        }

        // Рассчитываем среднюю температуру
        if ($num_forecasts > 0) {
            $average_temperature = round($total_temperature / $num_forecasts, 1);
            echo "<div class='average-forecast'>";
            echo "Средняя температура по данным $num_forecasts источников: " . htmlspecialchars($average_temperature) . "°C";
            echo "</div>";
        } else {
            echo "<p>Не удалось получить ни одного прогноза.</p>";
        }
    }
    ?>
</div>
</body>
</html>