package com.company;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashSet;
import java.util.Scanner;

public class Main {
    private static final Scanner scan = new Scanner(System.in);
    private static void printCondition() {
        System.out.println("Данная программа напечатает множество всех встречающихся в строке знаков арифметических операций и цифр");
    }
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
    private static String inputStr() {
        int choice;
        String str;

        System.out.println("Выберите вариант ввода:");
        System.out.println("1.Ввод из консоли");
        System.out.println("2.Ввод из файла");
        choice = readNum(1, 2);

        if (choice == 1) {
            str = inputStrFromConsole();
        }
        else {
            str = inputStrFromFile();
        }

        return str;
    }
    private static String inputStrFromConsole() {
        String str;
        do {
            System.out.println("Введите текст:");
            str = scan.nextLine();
        } while (str.isBlank());

        return str;
    }
    private static String inputStrFromFile() {
        String pathFile, str;
        boolean isInputFromFileSuccessfully;

        System.out.println("Данные в файле должны содержать текст");
        do {
            System.out.print("Введите путь к файлу и его имя с его раширением:");
            pathFile = scan.nextLine();
            isInputFromFileSuccessfully = checkFile(pathFile);
        } while(!isInputFromFileSuccessfully);

        str = readFile(pathFile);

        return str;
    }
    private static boolean checkFile(String path) {
        String bufStr, checkStr;
        File checkFile;
        boolean isFileCorrect;
        StringBuilder builderOfStr;

        checkFile = new File(path);
        builderOfStr = new StringBuilder();
        isFileCorrect = true;

        if (!checkFile.isFile()) {
            System.out.println("Файл не найден! Пожалуйста проверьте существование файла и введите путь заново");
            isFileCorrect = false;
        }
        if (isFileCorrect && !checkFile.canRead() ) {
            System.out.println("Файл не может быть прочитан! Пожалуйста проверьте файл и введите путь заново");
            isFileCorrect = false;
        }
        if (isFileCorrect) {
            try (Scanner fileScan = new Scanner(checkFile)) {
                while (fileScan.hasNextLine()) {
                    bufStr = fileScan.nextLine();
                    builderOfStr.append(bufStr);
                }

                checkStr = builderOfStr.toString();

                if (checkStr.isBlank()) {
                    isFileCorrect = false;
                    System.out.println("Файл пустой! Внесите изменения в файл и повторите попытку!");
                }
            }
            catch (FileNotFoundException e) {
                System.out.println("Файл по данному пути не существует! Пожалуйста проверьте файл и введите путь заново");
                isFileCorrect = false;
            }
        }
        return isFileCorrect;
    }
    private static String readFile(String path) {
        String bufStr, str;
        File file;
        StringBuilder builderOfStr;

        file = new File(path);
        builderOfStr = new StringBuilder();

        try (Scanner fileScan = new Scanner(file)) {
            do {
                bufStr = fileScan.nextLine();
                builderOfStr.append(bufStr);
                builderOfStr.append(' ');
            } while (fileScan.hasNextLine());
        }
        catch (FileNotFoundException e) {
            System.out.println("Файл по данному пути не существует. Пожалуйста проверьте файл и введите путь заново");
        }

        str = builderOfStr.toString();

        return str;
    }
    public static HashSet<Character> findSymbols(String line){
        HashSet<Character> setOfAvalibleAnswerSymbols = new HashSet<>();
        HashSet<Character> setOfAnswerSymbols = new HashSet<>();

        setOfAvalibleAnswerSymbols.add('+');
        setOfAvalibleAnswerSymbols.add('-');
        setOfAvalibleAnswerSymbols.add('/');
        setOfAvalibleAnswerSymbols.add('*');
        for (char i = '0'; i < '9'; i++){
            setOfAvalibleAnswerSymbols.add(i);
        }
        for (int i = 0; i < line.length(); i++){
            if (setOfAvalibleAnswerSymbols.contains(line.charAt(i))){
                setOfAnswerSymbols.add(line.charAt(i));
            }
        }
        return setOfAnswerSymbols;
    }
    private static void outputAnswer(HashSet<Character> answer) {
        int choice;

        System.out.println("Выберите вариант вывода:");
        System.out.println("1.Вывод в консоль");
        System.out.println("2.Вывод в файл");
        choice = readNum(1, 2);

        if (choice == 1) {
            outputAnswerToConsole(answer);
        }
        else {
            outputAnswerToFile(answer);
        }
    }

    private static void outputAnswerToConsole(HashSet<Character> answer) {
        System.out.println(answer);
    }

    private static void outputAnswerToFile(HashSet<Character> answer) {
        String path;
        boolean isFileIncorrect;

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
                            writer.write(answer.toString());
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
                        writer.write(answer.toString());
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
        String strIn;
        HashSet<Character> answerSymbols;

        printCondition();
        strIn = inputStr();
        answerSymbols = findSymbols(strIn);
        outputAnswer(answerSymbols);
        scan.close();
    }
}
