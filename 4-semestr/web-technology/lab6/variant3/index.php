<?php
session_start();

define('USER_DB', 'users.json');
define('COOKIE_NAME', 'remember_me');
define('COOKIE_EXPIRE', time() + 30 * 24 * 60 * 60); // 30 дней

// Обработка выхода
if (isset($_GET['logout'])) {
    setcookie(COOKIE_NAME, '', time() - 3600); // Удаляем куку
    session_destroy();
    header('Location: ' . $_SERVER['PHP_SELF']);
    exit;
}

// Проверка куки "Запомнить меня"
if (!isset($_SESSION['user']) && isset($_COOKIE[COOKIE_NAME])) {
    $cookieData = json_decode($_COOKIE[COOKIE_NAME], true);

    if (isset($cookieData['login']) && isset($cookieData['token'])) {
        $users = file_exists(USER_DB) ? json_decode(file_get_contents(USER_DB), true) : [];

        if (isset($users[$cookieData['login']])) {
            $validToken = md5($users[$cookieData['login']] . $_SERVER['REMOTE_ADDR']);

            if ($cookieData['token'] === $validToken) {
                $_SESSION['user'] = $cookieData['login'];
                header('Location: ' . $_SERVER['PHP_SELF']);
                exit;
            }
        }
    }
}

// Обработка формы авторизации/регистрации
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $login = trim(isset($_POST['login']) ? $_POST['login'] : '');
    $password = trim(isset($_POST['password']) ? $_POST['password'] : '');
    $action = isset($_POST['action']) ? $_POST['action'] : '';
    $remember = isset($_POST['remember']) ? (bool)$_POST['remember'] : false;

    // Валидация логина
    if (strlen($login) < 2) {
        $error = 'Логин должен содержать минимум 2 символа';
    }
    // Валидация пароля
    elseif (strlen($password) < 5) {
        $error = 'Пароль должен содержать минимум 5 символов';
    }
    // Проверка на допустимые символы
    elseif (!preg_match('/^[a-zA-Z0-9_]+$/', $login)) {
        $error = 'Логин может содержать только латинские буквы, цифры и символ подчеркивания';
    } else {
        // Чтение базы данных
        $users = file_exists(USER_DB) ? json_decode(file_get_contents(USER_DB), true) : [];

        if ($action === 'register') {
            // Регистрация нового пользователя
            if (isset($users[$login])) {
                $error = 'Пользователь с таким логином уже существует';
            } else {
                $users[$login] = md5($password);
                file_put_contents(USER_DB, json_encode($users));
                $_SESSION['user'] = $login;

                if ($remember) {
                    $token = md5($users[$login] . $_SERVER['REMOTE_ADDR']);
                    $cookieData = json_encode(['login' => $login, 'token' => $token]);
                    setcookie(COOKIE_NAME, $cookieData, COOKIE_EXPIRE);
                }

                header('Location: ' . $_SERVER['PHP_SELF']);
                exit;
            }
        } elseif ($action === 'login') {
            // Авторизация существующего пользователя
            if (!isset($users[$login]) || $users[$login] !== md5($password)) {
                $error = 'Неверный логин или пароль';
            } else {
                $_SESSION['user'] = $login;

                if ($remember) {
                    $token = md5($users[$login] . $_SERVER['REMOTE_ADDR']);
                    $cookieData = json_encode(['login' => $login, 'token' => $token]);
                    setcookie(COOKIE_NAME, $cookieData, COOKIE_EXPIRE);
                }

                header('Location: ' . $_SERVER['PHP_SELF']);
                exit;
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Авторизация</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 400px; margin: 0 auto; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input { width: 100%; padding: 8px; box-sizing: border-box; }
        button { padding: 8px 15px; background: #007bff; color: white; border: none; cursor: pointer; }
        button:hover { background: #0056b3; }
        .error { color: red; margin-bottom: 15px; }
        .success { color: green; margin-bottom: 15px; }
        .remember-me { display: flex; align-items: center; margin-bottom: 15px; }
        .remember-me input { width: auto; margin-right: 10px; }
    </style>
</head>
<body>
<?php if (isset($_SESSION['user'])): ?>
    <h1>Здравствуйте, <?php echo htmlspecialchars($_SESSION['user']); ?>!</h1>
    <p><a href="?logout=1">Выйти</a></p>
<?php else: ?>
    <h1>Авторизация</h1>

    <?php if (isset($error)): ?>
        <div class="error"><?php echo $error; ?></div>
    <?php endif; ?>

    <form method="post">
        <div class="form-group">
            <label for="login">Логин (мин. 2 символа):</label>
            <input type="text" id="login" name="login" required>
        </div>

        <div class="form-group">
            <label for="password">Пароль (мин. 5 символов):</label>
            <input type="password" id="password" name="password" required>
        </div>

        <div class="remember-me">
            <input type="checkbox" id="remember" name="remember">
            <label for="remember">Запомнить меня</label>
        </div>

        <div class="form-group">
            <button type="submit" name="action" value="login">Войти</button>
            <button type="submit" name="action" value="register">Зарегистрироваться</button>
        </div>
    </form>
<?php endif; ?>
</body>
</html>