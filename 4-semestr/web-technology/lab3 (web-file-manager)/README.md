# Условия заданий

## Основное задание

### 3. Объединение числовых наборов через POST-запрос

**Требуется:**
- Принять два набора чисел через POST-запрос
- Объединить их по следующим правилам:
  - Все числа из первого набора включаются в результат полностью
  - Из второго набора включаются только числа, отсутствующие в первом наборе
- **Пример:**
  - Вход: `[2, 2, 5, 3, 7, 2]` и `[2, 4, 4, 85]`
  - Выход: `[2, 2, 5, 3, 7, 2, 4, 4, 85]`

## Дополнительные задания (PHP)

### 1. Удаление дубликатов в многомерном массиве
- Написать скрипт, удаляющий повторяющиеся значения из многомерного массива
- Все дубликаты должны быть заменены одним экземпляром значения
- Пример: массив с пятью значениями `100` → остается одна `100`

### 2. Сортировка строк в текстовом файле
- Реализовать скрипт для сортировки строк файла по алфавиту
- Имя файла передается как аргумент командной строки
- Результат должен сохраняться в тот же файл

## Задание из методички (Вариант 6)

### Поиск файлов по критериям
**Требуется:**
- Написать функцию для поиска файлов в каталоге (включая подкаталоги) по параметрам:
  - Время создания в заданном диапазоне
  - Имя содержит указанную подстроку
- Параметры поиска должны получаться через веб-форму

## Расширенные задания

### 1. Веб-файловый менеджер
**Основной функционал:**
- Добавление/удаление/перемещение файлов
- Управление каталогами (создание/удаление)
- Просмотр содержимого:
  - Графические файлы - отображение
  - Текстовые файлы - показ первых 30 символов

**Дополнительные возможности:**
- Редактирование текстовых файлов
- Конвертация графических форматов
- Шифрование/дешифрование файлов
- Работа с архивами (создание/распаковка)