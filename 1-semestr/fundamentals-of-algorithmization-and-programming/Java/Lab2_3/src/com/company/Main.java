package com.company;

import java.util.NoSuchElementException;
import java.util.Scanner;
import java.io.*;


public class Main {
    private static final Scanner scan = new Scanner(System.in);

    public static int getNum(int min, int max) {

        boolean isNotCorrect;
        int num;

        num = 0;

        do {
            isNotCorrect = false;
            try {
                num = Integer.parseInt(scan.nextLine());
            }
            catch (NumberFormatException e) {
                isNotCorrect = true;
                System.out.print("Некорректный ввод! Введите значение еще раз: " );
            }
            if ((!isNotCorrect) && (num < min || num > max)) {
                isNotCorrect = true;
                System.out.print("Недопустимое значение! Введите значение еще раз: ");
            }

        } while (isNotCorrect);
        return num;
    }
    public static boolean checkFile(File file){
        final int MIN_N = 1, MAX_N = 10;
        int n;
        boolean isFileIncorrect = false;

        n = 0;

        if (file.isFile()) {
            if (file.canRead()) {
                try (Scanner fileScan = new Scanner(file)) {
                    n = Integer.parseInt(fileScan.nextLine());
                    if (fileScan.hasNext()){
                        System.out.println("В файле данные представлены в неправильном формате. Пожалуйста проверьте файл и введите путь заново");
                        isFileIncorrect = true;
                    }
                }
                catch (FileNotFoundException e) {
                    System.out.println("Файл по данному пути не существует. Пожалуйста проверьте файл и введите путь заново");
                    isFileIncorrect = true;
                }
                catch (NoSuchElementException e) {
                    System.out.println("В файле данные представлены в неправильном формате. Пожалуйста проверьте файл и введите путь заново");
                    isFileIncorrect = true;
                }

                if (!isFileIncorrect && (n < MIN_N || n > MAX_N)) {
                    System.out.println("В файле данные выходят за пределы допустимых значений. Пожалуйста проверьте файл и введите путь заново");
                    isFileIncorrect = true;
                }
            }
            else {
                System.out.println("Файл по данному пути не может быть прочитан. Пожалуйста проверьте файл и введите путь заново");
                isFileIncorrect = true;
            }
        }
        else {
            System.out.println("Файла по данному пути не существует. Пожалуйста проверьте существование файла и введите путь заново");
            isFileIncorrect = true;
        }

        return isFileIncorrect;
    }

    public static int inputNFromFile(File file) {
        int n;
        n = 0;
        try (Scanner fileScan = new Scanner(file)) {
            n = Integer.parseInt(fileScan.nextLine());

        } catch (IOException e) {
            System.out.println("Не удалось считать данные из файла!");
        }
        return n;
    }

    public static int inputN() {
    final int MIN_N = 1, MAX_N = 10;
        int choice, n;
        boolean isFileIncorrect;
        String pathFile;
        File inputFile;

        System.out.println("Выберите вариант ввода:");
        System.out.println("1. Ввод из консоли");
        System.out.println("2. Ввод из файла");
        System.out.print("Использовать вариант: ");
        choice = getNum(1, 2);

        if (choice == 1) {
            System.out.print( "Введите порядок матрицы от " + MIN_N + " до " + MAX_N + ":");
            n = getNum(MIN_N, MAX_N);
        }
        else {
            System.out.println("Данные в файле должны содержать натуральное число - порядок матрицы N от " + MIN_N + " до " + MAX_N);
            do {
                System.out.print("Введите путь к файлу с его раширением:");
                pathFile = scan.nextLine() ;
                inputFile = new File(pathFile);
                isFileIncorrect = checkFile(inputFile);
            } while(isFileIncorrect);
            n = inputNFromFile(inputFile);
        }
        return n;
    }
    public static void fillMatrix(int[][] matrix, int n) {

        int i, j, counter;

        i = 0;
        counter = 1;

        do {
            if (i % 2 == 0) {
                for (j = 0; j < n; j++){
                    matrix[i][j] = counter;
                    counter++;
                }
            }
            else {
                for (j = n - 1; j > -1; j--) {
                    matrix[i][j] = counter;
                    counter++;
                }
            }
            i++;
        } while (i < n);
    }
    public static void outputMatrix(int[][] matrix, int  n) {

        int i, j, choice;
        String path, element ;
        boolean isFileIncorrect;

        System.out.println("Выберите вариант вывода: ");
        System.out.println("1. Вывод в консоль");
        System.out.println("2. Вывод в файл");
        System.out.print("Использовать вариант: ");
        choice = getNum(1, 2);

        if (choice == 1) {
            for (i = 0; i < n; i++) {
                for (j = 0; j < n; j++) {
                    System.out.printf("%5d", matrix[i][j]);
                }
                System.out.println();
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
                                for (i = 0; i < n; i++) {
                                    for (j = 0; j < n; j++) {
                                        element = String.format("%5d", matrix[i][j]);
                                        writer.write(element);
                                    }
                                    writer.write('\n');
                                }
                            }
                        } else {
                            System.out.println("Файл доступен только для чтения!");
                            isFileIncorrect = true;
                        }
                    } else {
                        outputFile.createNewFile();
                        try (FileWriter writer = new FileWriter(outputFile)) {
                            for (i = 0; i < n; i++) {
                                for (j = 0; j < n; j++) {
                                    element = String.format("%5d", matrix[i][j]);
                                    writer.write(element);
                                }
                                writer.write('\n');
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
    public static void main(String[] args) {
        int n;
        System.out.println("Данная программа заполнит матрицу чисел змейкой");

        n = inputN();

        int[][] matrix = new int[n][n];

        fillMatrix(matrix, n);
        outputMatrix(matrix, n);
        scan.close();

    }
}
