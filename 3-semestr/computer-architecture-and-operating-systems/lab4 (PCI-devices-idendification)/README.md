# Лабораторная работа: Адресация устройств шин PCI/PCI Express

## Цель работы
Изучение механизмов адресации и конфигурирования периферийных устройств в архитектурах PCI и PCI Express.

## Теоретическая часть

### 1. Способы адресации:
- **Пространство памяти** (Memory Address Space)
- **Пространство ввода-вывода** (I/O Address Space)
- **Конфигурационное пространство** (Configuration Space)

### 2. Методы доступа:
- Опрос устройств (Polling)
- Идентификация по Vendor/Device ID
- Конфигурирование BAR (Base Address Registers)

## Практическое задание

### Задание 1: Опрос устройств
1. Реализовать алгоритм сканирования шины PCI/PCIe
2. Определить список подключенных устройств
3. Вывести параметры:
   - Vendor ID
   - Device ID
   - Class Code
   - Тип устройства

### Задание 2: Конфигурирование
1. Прочитать/записать значения в BAR-регистры
2. Настроить прерывания (MSI/MSI-X)
3. Изменить параметры:
   - Latency Timer
   - Cache Line Size

## Инструменты

### Оборудование:
- ПК с PCI/PCIe слотами
- Контрольные устройства (тестовые платы)

### ПО:
- WinAPI/DDK для Windows
- libpci для Linux
- PCI Utilities (lspci, setpci)

## Отчетные материалы

1. Результаты сканирования шины:
   - Таблица обнаруженных устройств
   - Дерево устройств PCIe

2. Примеры кода:
   - Чтение конфигурационного пространства
   - Модификация BAR-регистров

3. Анализ:
   - Сравнение PCI vs PCIe
   - Временные характеристики доступа

## Критерии оценки

1. Полнота идентификации устройств
2. Корректность работы с BAR-регистрами
3. Анализ полученных результатов
4. Оформление отчета
