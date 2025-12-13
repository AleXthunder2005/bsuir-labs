# Лабораторная работа: Установка и настройка ПО

## Необходимое программное обеспечение

1. Веб-сервер Apache (версии 2.2.x или новее)
   Ссылка для скачивания: https://www.apachelounge.com/download/

2. СУБД MySQL (версии 5.1.x, 5.5.x или новее)
   Ссылка для скачивания: https://dev.mysql.com/downloads/mysql/

3. Среда исполнения PHP (версии 5.3.x или новее)
   Ссылка для скачивания: https://windows.php.net/download/

4. phpMyAdmin (версии 3.3.x или новее)
   Ссылка для скачивания: https://www.phpmyadmin.net/

5. Notepad++ (версии 5.8.x или новее)
   Ссылка для скачивания: https://notepad-plus-plus.org/

## Пошаговая инструкция установки

### 1. Подготовка к установке Apache
- Откройте командную строку
- Выполните команду: 
  telnet 127.0.0.1 80
- Убедитесь, что соединение не устанавливается (порт 80 свободен)

### 2. Установка Apache
- Запустите установщик Apache
- Выберите настройки по умолчанию
- Завершите установку

### 3. Установка PHP
- Запустите установщик PHP
- Выберите опцию "Работать как модуль Apache"
- Включите расширения:
  - mysql
  - mysqli
  - gd
  - mbstring
- Завершите установку

### 4. Установка MySQL
- Запустите установщик MySQL
- Выберите настройки по умолчанию
- Завершите установку

### 5. Установка Notepad++
- Запустите установщик Notepad++
- Выберите настройки по умолчанию
- Завершите установку

## Настройка конфигурационных файлов

### Настройка Apache (httpd.conf)
1. Найдите параметр DocumentRoot
2. Измените его значение на:
   DocumentRoot "c:/www"
3. Обновите все соответствующие пути
4. Измените параметр DirectoryIndex:
   DirectoryIndex index.php index.html

### Настройка PHP (php.ini)
Установите следующие параметры:
short_open_tag = On
output_buffering = Off
max_execution_time = 30
max_input_time = 60
memory_limit = 128M
error_reporting = E_ALL
display_errors = On
post_max_size = 64M
upload_max_filesize = 64M
session.save_path = "C:\WINDOWS\Temp"
date.timezone = 'Europe/Minsk'

## Установка phpMyAdmin
1. Создайте папку c:/www/phpmyadmin/
2. Распакуйте содержимое архива phpMyAdmin в эту папку

## Завершение установки
1. Перезагрузите компьютер
2. Проверьте работу, открыв в браузере:
   http://localhost/
3. Для доступа к phpMyAdmin перейдите по адресу:
   http://localhost/phpmyadmin/

Примечание: Для дополнительной помощи можно использовать видеоинструкции из материалов курса.