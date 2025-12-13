package com.company;
import java.util.NoSuchElementException;
import java.util.Scanner;
import java.io.*;
public class Main {

    private static final Scanner scan = new Scanner(System.in);
    private static int readNum(int min, int max) {
        int n;
        boolean isIncorrect;
        n = 0;
        do {
            isIncorrect = false;
            try {
                n = Integer.parseInt(scan.nextLine());
            }
            catch (Exception err) {
                System.out.println("Вы ввели некорректные данные. Попробуйте снова");
                isIncorrect = true;
            }
            if (!isIncorrect && (n < min || n > max)) {
                System.out.println("Введено значение не входящее в диапазон допустимых значений");
                isIncorrect = true;
            }
        } while (isIncorrect);
        return n;
    }
    private static void printCondition() {
        final int MIN_ARR_LENGTH = 1, MAX_ARR_LENGTH = 10, MIN_ARR_VALUE = -1000, MAX_ARR_VALUE = 1000;
        System.out.println("Данная программа сортирует массив методом простых вставок.");
        System.out.println("Диапазон значений для длины массива - от " + MIN_ARR_LENGTH + " до " + MAX_ARR_LENGTH + ".");
        System.out.println("Диапазон значений для элементов массива - от " + MIN_ARR_VALUE + " до " + MAX_ARR_VALUE + ".");
    }
    private static int[] inputArr() {
        int choice;
        int[] arr;

        System.out.println("Выберите вариант ввода:");
        System.out.println("1.Ввод из консоли");
        System.out.println("2.Ввод из файла");
        choice = readNum(1, 2);

        if (choice == 1) {
            arr = inputArrFromConsole();
        }
        else {
            arr = inputArrFromFile();
        }

        return arr;
    }
    private static int[] inputArrFromConsole() {
        final int MIN_ARR_LENGTH = 1, MAX_ARR_LENGTH = 10, MIN_ARR_VALUE = -1000, MAX_ARR_VALUE = 1000;
        int len;
        int[] arr;

        System.out.println("Число элементов массива: ");
        len = readNum(MIN_ARR_LENGTH, MAX_ARR_LENGTH);
        arr = new int[len];

        System.out.println("Введите массив для сортировки");
        for (int i = 0; i < arr.length; i++) {
            System.out.println("Введите элемент массива " + (i + 1) + ": ");
            arr[i] = readNum(MIN_ARR_VALUE, MAX_ARR_VALUE);
        }
        return arr;
    }
    private static int[] inputArrFromFile() {
        String pathFile;
        int[] arr;
        boolean isInputFromFileSuccessfully;

        System.out.println("Данные в файле должны содержать количество элементов в первой строке и элементы массива во второй строке");
        do {
            System.out.print("Введите путь к файлу и его имя с его раширением:");
            pathFile = scan.nextLine();
            isInputFromFileSuccessfully = checkFile(pathFile);
        } while(!isInputFromFileSuccessfully);

        arr = readFile(pathFile);

        return arr;
    }
    private static boolean checkFile(String path){
        final int MIN_ARR_LENGTH = 1, MAX_ARR_LENGTH = 10, MIN_ARR_VALUE = -1000, MAX_ARR_VALUE = 1000;
        int buf, len;
        boolean isFileCorrect;
        File checkFile;

        checkFile = new File(path);
        isFileCorrect = true;

        if (!checkFile.isFile()) {
            System.out.println("Файл не найден! Пожалуйста проверьте существование файла и введите путь заново");
            isFileCorrect = false;
        }
        if (isFileCorrect && !checkFile.canRead() ) {
            System.out.println("Файл не может быть прочитан! Пожалуйста проверьте файл и введите путь заново");
            isFileCorrect = false;
        }
        if (isFileCorrect){
            try (Scanner fileScan = new Scanner(checkFile)) {
                len = fileScan.nextInt();
                if (len <= MAX_ARR_LENGTH && len >= MIN_ARR_LENGTH) {
                    for (int i = 0; i < len; i++) {
                        buf = fileScan.nextInt();
                        if ((buf > MAX_ARR_VALUE || buf < MIN_ARR_VALUE)) {
                            System.out.println("В файле данные выходят за пределы допустимых значений. Пожалуйста проверьте файл и введите путь заново");
                            isFileCorrect = false;
                        }
                    }
                } else {
                    System.out.println("В файле данные выходят за пределы допустимых значений. Пожалуйста проверьте файл и введите путь заново");
                    isFileCorrect = false;
                }
                if (isFileCorrect && fileScan.hasNext()){
                    System.out.println("В файле данные представлены в неправильном формате. Пожалуйста проверьте файл и введите путь заново");
                    isFileCorrect = false;
                }
            } catch (FileNotFoundException e) {
                System.out.println("Файл по данному пути не существует. Пожалуйста проверьте файл и введите путь заново");
                isFileCorrect = false;
            } catch (NoSuchElementException e) {
                System.out.println("В файле данные представлены в неправильном формате. Пожалуйста проверьте файл и введите путь заново");
                isFileCorrect = false;
            }
        }
        return isFileCorrect;
    }
    private static int[] readFile(String path){
        int[] arr;
        int len, buf;
        File file;

        arr = null;
        file = new File(path);

        try (Scanner fileScan = new Scanner(file)) {
            len = fileScan.nextInt();
            arr = new int[len];
            for (int i = 0; i < len; i++) {
                buf = fileScan.nextInt();
                arr[i] = buf;
            }
        } catch (IOException e) {
            System.out.println("Не удалось считать файл");
        }
        return arr;
    }
    private static int[] sortArr(int[] arr) {
        int i, j, buff;
        for (i = 1; i < arr.length; i++) {
            buff = arr[i];
            j = i;
            while ((j > 0) && (arr[j - 1] > buff)) {
                arr[j] = arr[j - 1];
                j--;
            }
            arr[j] = buff;
        }
        return arr;
    }
    private static void outputArr(int[] arr) {
        int choice;

        System.out.println("Выберите вариант вывода:");
        System.out.println("1.Вывод в консоль");
        System.out.println("2.Вывод в файл");
        choice = readNum(1, 2);

        if (choice == 1) {
            outputArrToConsole(arr);
        }
        else {
            outputArrToFile(arr);
        }
    }

    private static void outputArrToConsole(int[] arr) {
        int i;
        for (i = 0; i < arr.length; i++){
            System.out.print(arr[i] + " ");
        }
    }

    private static void outputArrToFile(int[] arr) {
        String path;
        boolean isFileIncorrect;
        int i;

        System.out.println("Для вывода введите путь к файлу.");
        System.out.println("Если файл отсутствует то он будет создан автоматически по указанному пути или в корневой папке программы (по умолчанию)");
        do {
            isFileIncorrect = false;
            System.out.print("Введите путь к файлу и его имя c расширением: ");
            path = scan.nextLine();
            File outputFile = new File(path);
            try {
                if (outputFile.isFile()) {
                    if (outputFile.canWrite()) {
                        try (FileWriter writer = new FileWriter(outputFile)) {
                            for (i = 0; i < arr.length; i++){
                                writer.write(arr[i] + " ");
                            }
                        }
                    }
                    else {
                        System.out.println("Файл доступен только для чтения!");
                        isFileIncorrect = true;
                    }
                }
                else {
                    outputFile.createNewFile();
                    try (FileWriter writer = new FileWriter(outputFile)) {
                        for (i = 0; i < arr.length; i++){
                            writer.write(arr[i] + " ");
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
    public static void main(String[] args) {
        int[] numArr;
        printCondition();
        numArr = inputArr();
        numArr = sortArr(numArr);
        outputArr(numArr);
        scan.close();
    }
}
