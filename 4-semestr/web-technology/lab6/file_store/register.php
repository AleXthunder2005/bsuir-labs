<?php
session_start();

if (isset($_SESSION['user_id'])) {
    header('Location: filemanager.php');
    exit;
}

$error = '';
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $login = trim(isset($_POST['login']) ? $_POST['login'] : '');
    $password = trim(isset($_POST['password']) ? $_POST['password'] : '');
    $name = trim(isset($_POST['name']) ? $_POST['name'] : '');

    if (empty($login) || empty($password) || empty($name)) {
        $error = 'Все поля обязательны для заполнения';
    } elseif (strlen($password) < 6) {
        $error = 'Пароль должен содержать не менее 6 символов';
    } else {
        $usersFile = 'auth/users.json';
        $data = json_decode(file_get_contents($usersFile), true);

        //проверка на занятость логина
        foreach ($data['users'] as $user) {
            if ($user['login'] === $login) {
                $error = 'Этот логин уже занят';
                break;
            }
        }

        if (empty($error)) {
            $newId = ++$data['last_id'];
            $newUser = [
                'user_id' => $newId,
                'login' => $login,
                'password' => md5($password),
                'name' => $name
            ];

            $data['users'][] = $newUser;
            file_put_contents($usersFile, json_encode($data, JSON_PRETTY_PRINT));

            $userDir = 'store/' . $newId;
            if (!file_exists($userDir)) {
                mkdir($userDir, 0755, true);
            }

            $success = 'Регистрация прошла успешно! Теперь вы можете <a href="login.php">войти</a>.';
        }
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Регистрация</title>
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
        .success {
            color: #2ecc71;
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
        .password-hint {
            font-size: 12px;
            color: #888;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="auth-container">
    <div class="logo">Файловый Менеджер</div>
    <h1>Регистрация</h1>

    <?php if ($error): ?>
        <div class="error"><?= htmlspecialchars($error) ?></div>
    <?php endif; ?>

    <?php if ($success): ?>
        <div class="success"><?= $success ?></div>
    <?php else: ?>
        <form method="post">
            <div class="form-group">
                <label for="name">Имя</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="login">Логин</label>
                <input type="text" id="login" name="login" required>
            </div>
            <div class="form-group">
                <label for="password">Пароль</label>
                <input type="password" id="password" name="password" required minlength="6">
                <div class="password-hint">Минимум 6 символов</div>
            </div>
            <button type="submit">Зарегистрироваться</button>
        </form>
    <?php endif; ?>

    <div class="auth-footer">
        Уже есть аккаунт? <a href="login.php">Войти</a>
    </div>
</div>
</body>
</html>