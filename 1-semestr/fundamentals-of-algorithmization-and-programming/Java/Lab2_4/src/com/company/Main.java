package com.company;
import java.util.NoSuchElementException;
import java.util.Scanner;
import java.io.*;

import static java.lang.Math.sqrt;

public class Main {
    private static final Scanner scan = new Scanner(System.in);

    public static int readNum(int min, int max) {
        int n;
        boolean isNotCorrect;
        n = 0;
        do {
            isNotCorrect = false;
            try {
                n = Integer.parseInt(scan.nextLine());
            }
            catch (Exception err) {
                System.out.println("Вы ввели некорректные данные. Попробуйте снова");
                isNotCorrect = true;
            }
            if (!isNotCorrect && (n < min || n > max)) {
                System.out.println("Введено значение не входящее в диапазон допустимых значений");
                isNotCorrect = true;
            }
        } while (isNotCorrect);
        return n;
    }

    public static boolean checkFile(File file) {
        int n, i, buf;
        int[] checkArr;
        boolean isFileCorrect;
        final int MIN_ARR_LENGTH = 1, MAX_ARR_LENGTH = 20, MIN_ARR_VALUE = 1, MAX_ARR_VALUE = 100;

        isFileCorrect = true;

        if (!file.isFile()) {
            System.out.println("Файл не найден! Пожалуйста проверьте существование файла и введите путь заново");
            isFileCorrect = false;
        }
        if (isFileCorrect && !file.canRead() ) {
            System.out.println("Файл не может быть прочитан! Пожалуйста проверьте файл и введите путь заново");
            isFileCorrect = false;
        }
        if (isFileCorrect) {
            try (Scanner fileScan = new Scanner(file)) {
                n = Integer.parseInt(fileScan.nextLine());
                checkArr = new int[n];
                if (n < MIN_ARR_LENGTH || n > MAX_ARR_LENGTH) {
                    System.out.println("Недопустимое значение для количества элементов массива!");
                    isFileCorrect = false;
                }
                else {
                    i = 0;
                    do {
                        buf = fileScan.nextInt();
                        if (buf < MIN_ARR_VALUE || buf > MAX_ARR_VALUE) {
                            System.out.println("Значение элемента выходит за возможные пределы!\nВнесите изменения в файл и повторите попытку!");
                            isFileCorrect = false;
                        }
                        else
                            checkArr[i] = buf;
                        i++;
                    } while (isFileCorrect && i < n);
                }

            }
            catch (FileNotFoundException e) {
                System.out.println("Файл по данному пути не существует. Пожалуйста проверьте файл и введите путь заново");
                isFileCorrect = false;
            }
            catch (NoSuchElementException e) {
                System.out.println("В файле данные представлены в неправильном формате. Пожалуйста проверьте файл и введите путь заново");
                isFileCorrect = false;
            }
            catch (Exception e) {
                System.out.println("В файле данные представлены в неправильном формате. Пожалуйста проверьте файл и введите путь заново");
                isFileCorrect = false;
            }
        }

        return isFileCorrect;
    }
    public static int[] inputArrFromFile(File file) {
        int n;
        int[] arr;
        arr = null;
        try (Scanner fileScan = new Scanner(file)) {
            n = Integer.parseInt(fileScan.nextLine());
            arr = new int[n];
            for (int i = 0; i < n; i++)
                arr[i] = fileScan.nextInt();
        }
        catch (IOException e) {
            System.out.println("Не удалось считать данные из файла!");
        }
        return arr;
    }

    public static int[] inputArrFromConsole(int length) {
        final int  MIN_ARR_VALUE = 1, MAX_ARR_VALUE = 100;
        int i;
        int[] arr;
        arr = new int [length];
        System.out.println("Введите все элементы массива");
        for (i = 0; i < length; i++)
        {
            System.out.println("Введите элемент последовательности №" + (i + 1) + ":");
            arr[i] = readNum(MIN_ARR_VALUE, MAX_ARR_VALUE);
        }
        return arr;
    }

    public static int[] inputArr() {
        final int MIN_ARR_LENGTH = 1, MAX_ARR_LENGTH = 20, MIN_ARR_VALUE = 1, MAX_ARR_VALUE = 100;
        int choice, n;
        int[] arr;
        boolean isFileCorrect;
        String pathFile;
        File inputFile;

        System.out.println("Допустимые значения:");
        System.out.println("Количество элементов - натуральное число от " + MIN_ARR_LENGTH + " до " + MAX_ARR_LENGTH);
        System.out.println("Элементы массива - натуральные числа от " + MIN_ARR_VALUE + " до " + MAX_ARR_VALUE);

        System.out.println("Выберите вариант ввода:");
        System.out.println("1.Ввод из консоли");
        System.out.println("2.Ввод из файла");
        choice = readNum(1, 2);

        if (choice == 1) {
            System.out.println("Введите количество элементов массива");
            n = readNum(MIN_ARR_LENGTH, MAX_ARR_LENGTH);
            arr = inputArrFromConsole(n);
        }
        else {
            System.out.println("Данные в файле должны содержать натуральное число");
            do {
                System.out.print("Введите путь к файлу с его раcширением:");
                pathFile = scan.nextLine() ;
                inputFile = new File(pathFile);
                isFileCorrect = checkFile(inputFile);
            } while(!isFileCorrect);
            arr = inputArrFromFile(inputFile);
        }
        return arr;
    }

    public static void outputData(int count) {

        int choice;
        String path;
        boolean isFileIncorrect;

        System.out.println("Выберите вариант вывода: ");
        System.out.println("1. Вывод в консоль");
        System.out.println("2. Вывод в файл");
        System.out.print("Использовать вариант: ");
        choice = readNum(1, 2);

        if (choice == 1) {
            if (count == 0) {
                System.out.println("Среди элементов массива нет простых чисел");
            }
            else {
                System.out.println("Количество простых чисел среди элементов массива: " + count);
            }
        }
        else {
            System.out.println("Для вывода введите путь к файлу и его имя." + '\n' + "Если файл отсутствует то он будет создан автоматически по указанному пути или в корневой папке программы (по умолчанию).");
            do {
                isFileIncorrect = false;
                System.out.print("Введите путь к файлу и его имя c расширением: ");
                path = scan.nextLine();
                File outputFile = new File(path);
                try {
                    if (outputFile.isFile()) {
                        if (outputFile.canWrite()) {
                            try (FileWriter writer = new FileWriter(outputFile)) {
                                if (count == 0) {
                                    writer.write("Среди элементов массива нет простых чисел");
                                }
                                else {
                                    writer.write("Количество простых чисел среди элементов массива: " + count);
                                }
                            }
                        } else {
                            System.out.println("Файл доступен только для чтения!");
                            isFileIncorrect = true;
                        }
                    } else {
                        outputFile.createNewFile();
                        try (FileWriter writer = new FileWriter(outputFile)) {
                            if (count == 0) {
                                writer.write("Среди элементов массива нет простых чисел");
                            }
                            else {
                                writer.write("Количество простых чисел среди элементов массива: " + count);
                            }
                        }
                    }
                }
                catch (IOException e) {
                    System.out.println("Не удалось вывести в файл!");
                    isFileIncorrect = true;
                }
            } while (isFileIncorrect);
            System.out.println("Вывод данных... успешно!");
        }
    }

    public static boolean checkNumber (int num) {
        int i;
        double numRoot;
        boolean isPrimeNumber;

        numRoot = sqrt(num);
        i = 1;
        do {
            i++;
        } while (num % i != 0 && i <= numRoot);
        if (num == 1)
            isPrimeNumber = false;
        else
            isPrimeNumber = (i > numRoot);

        return isPrimeNumber;

    }

    public static int getCountOfPrimeNumbers(int[] arr) {
        int count;
        boolean isPrimeNumber;

        count = 0;

        for (int i = 0; i < arr.length; i++) {
            isPrimeNumber = checkNumber(arr[i]);
            if(isPrimeNumber) {
                count++;
            }
        }
        return count;
    }

    public static void main(String[] args) {
        int[] arrA;
        int countOfPrimeNumbers;
        System.out.println("Данная программа вычислит количество простых чисел в массиве");
        arrA = inputArr();
        countOfPrimeNumbers = getCountOfPrimeNumbers(arrA);
        outputData(countOfPrimeNumbers);
        scan.close();
    }
}
