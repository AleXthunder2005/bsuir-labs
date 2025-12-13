<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'vendor/autoload.php';

class MailSender {
    private $recipientsFile;
    private $senderEmail;
    private $senderName;
    private $smtpHost = 'smtp.gmail.com';
    private $smtpPort = 587;
    private $smtpUsername = 'aleksandrnar2005@gmail.com';
    private $smtpPassword = 'xppvaixbvnixjwnw';

    public function __construct($recipientsFile, $senderEmail, $senderName) {
        $this->recipientsFile = $recipientsFile;
        $this->senderEmail = $senderEmail;
        $this->senderName = $senderName;
    }

    public function getRecipients() {
        if (!file_exists($this->recipientsFile)) {
            throw new Exception("Файл с адресатами не найден");
        }

        $json = file_get_contents($this->recipientsFile);
        $recipients = json_decode($json, true);

        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new Exception("Ошибка при чтении JSON: " . json_last_error_msg());
        }

        return $recipients;
    }

    public function send_via_SMTP($email, $subject, $message) {
        $mail = new PHPMailer(true);
        $mail->isSMTP();
        $mail->Host = $this->smtpHost;
        $mail->SMTPAuth = true;
        $mail->Username = $this->smtpUsername;
        $mail->Password = $this->smtpPassword;
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = $this->smtpPort;

        $mail->setFrom($this->senderEmail, $this->senderName);
        $mail->addAddress($email);
        $mail->isHTML(false);
        $mail->CharSet = 'UTF-8';
        $mail->Encoding = 'base64';
        $mail->Subject = '=?UTF-8?B?'.base64_encode($subject).'?=';
        $mail->Body = $message;

        return $mail->send();
    }

    public function send_via_mail_function($email, $subject, $message) {
        $headers = "From: $this->senderName <$this->senderEmail>\r\n";
        $headers .= "Content-Type: text/plain; charset=UTF-8\r\n";
        $headers .= "Content-Transfer-Encoding: base64\r\n";

        $encodedSubject = '=?UTF-8?B?'.base64_encode($subject).'?=';
        $encodedMessage = base64_encode($message);

        return mail($email, $encodedSubject, $encodedMessage, $headers);
    }

    public function send_emails($subject, $message, $useSmtp = true) {
        try {
            $recipients = $this->getRecipients();
        } catch (Exception $e) {
            return ['error' => $e->getMessage()];
        }

        $results = [];

        foreach ($recipients as $email) {
            if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                $results[$email] = 'Неверный email-адрес';
                continue;
            }

            try {
                if ($useSmtp) {
                    $this->send_via_SMTP($email, $subject, $message);
                    $results[$email] = 'Успешно отправлено';
                } else {
                    $this->send_via_mail_function($email, $subject, $message);
                    $results[$email] = 'Успешно отправлено';
                }
            } catch (Exception $e) {
                $results[$email] = 'Ошибка: ' . $e->getMessage();
            }
        }

        return $results;
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $mailSender = new MailSender('recipients.json', 'aleksandrnar2005@gmail.com', 'Aleksandr Narivonchyk');

    $subject = trim($_POST['subject']);
    $message = trim($_POST['message']);
    $useSmtp = true;

    if (empty($subject) || empty($message)) {
        die('Заполните все поля');
    }

    $result = $mailSender->send_emails($subject, $message, $useSmtp);

    echo '<h2>Результаты отправки:</h2>';
    echo '<ul>';
    foreach ($result as $email => $status) {
        echo "<li>$email: $status</li>";
    }
    echo '</ul>';
    exit;
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Отправка писем</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        textarea { width: 100%; height: 150px; }
        button { padding: 10px 15px; background: #4CAF50; color: white; border: none; cursor: pointer; }
        .checkbox-group { margin: 15px 0; }
    </style>
</head>
<body>
<h1>Отправка писем</h1>
<form method="post">
    <div class="form-group">
        <label>Тема письма:</label>
        <input type="text" name="subject" required>
    </div>

    <div class="form-group">
        <label>Текст письма:</label>
        <textarea name="message" required></textarea>
    </div>

    <button type="submit">Отправить</button>
</form>
</body>
</html>