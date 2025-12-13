<?php
session_start();

//Если в активной сессии есть user_id то redirect
if (isset($_SESSION['user_id'])) {
    header('Location: filemanager.php');
    exit;
}

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $login = isset($_POST['login']) ? $_POST['login'] : '';
    $password = isset($_POST['password']) ? $_POST['password'] : '';

    if (!empty($login) && !empty($password)) {
        $users = json_decode(file_get_contents('auth/users.json'), true);

        foreach ($users['users'] as $user) {
            if ($user['login'] === $login && $user['password'] === md5($password)) {
                $_SESSION['user_id'] = $user['user_id'];
                $_SESSION['login'] = $user['login'];
                $_SESSION['name'] = $user['name'];

                $userDir = 'store/' . $user['user_id'];
                if (!file_exists($userDir)) {
                    mkdir($userDir, 0755, true);
                }

                header('Location: filemanager.php');
                exit;
            }
        }

        $error = 'Неверный логин или пароль';
    } else {
        $error = 'Заполните все поля';
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Вход в систему</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background-color: #f5f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .auth-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            padding: 40px;
            text-align: center;
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
            font-weight: 600;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        input:focus {
            border-color: #4a90e2;
            outline: none;
        }
        .error {
            color: #e74c3c;
            margin-bottom: 20px;
            font-size: 14px;
        }
        button {
            background-color: #4a90e2;
            color: white;
            border: none;
            padding: 12px 20px;
            width: 100%;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }
        button:hover {
            background-color: #3a7bc8;
        }
        .auth-footer {
            margin-top: 25px;
            font-size: 14px;
            color: #666;
        }
        .auth-footer a {
            color: #4a90e2;
            text-decoration: none;
            font-weight: 500;
        }
        .auth-footer a:hover {
            text-decoration: underline;
        }
        .logo {
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: 700;
            color: #4a90e2;
        }
    </style>
</head>
<body>
<div class="auth-container">
    <div class="logo">Файловый Менеджер</div>
    <h1>Вход в систему</h1>

    <?php if ($error): ?>
        <div class="error"><?= htmlspecialchars($error) ?></div>
    <?php endif; ?>

    <form method="post">
        <div class="form-group">
            <label for="login">Логин</label>
            <input type="text" id="login" name="login" required>
        </div>
        <div class="form-group">
            <label for="password">Пароль</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit">Войти</button>
    </form>

    <div class="auth-footer">
        Нет аккаунта? <a href="register.php">Зарегистрируйтесь</a>
    </div>
</div>
</body>
</html>