package com.company;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

public class Main {
    private static final Scanner scan = new Scanner(System.in);
    private static void printCondition() {
        System.out.println("Данная программа из последовательности символов A, B, C удалит AAAA, ABС, а из BABA оставит только BA.");
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
                System.out.println("Вы ввели некорректные данные. Попробуйте снова:");
                isIncorrect = true;
            }
            if (!isIncorrect && (n < min || n > max)) {
                System.out.println("Введено значение не входящее в диапазон допустимых значений! Попробуйте снова:");
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

    private static boolean checkLine(String str) {
        boolean isCorrect = true;
        for (int i = 0; (i < str.length()) && (isCorrect == true); i++) {
            isCorrect = (str.charAt(i) == 'A') || (str.charAt(i) == 'B') || (str.charAt(i) == 'C');
        }
        return isCorrect;
    }

    private static String inputStrFromConsole() {
        String str;
        do {
            System.out.println("Введите последовательность символов A,B и C:");
            str = scan.nextLine();
        } while (str.isBlank() || !checkLine(str));

        return str;
    }
    private static String inputStrFromFile() {
        String pathFile, str;
        boolean isInputFromFileSuccessfully;

        System.out.println("Данные в файле должны содержать последовательность символов A,B и C");
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
        checkStr = "";
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
            if ((isFileCorrect) && (!checkLine(checkStr))){
                isFileCorrect = false;
                System.out.println("В файле должна быть последовательность символов A, B и С!");
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
            } while (fileScan.hasNextLine());
        }
        catch (FileNotFoundException e) {
            System.out.println("Файл по данному пути не существует. Пожалуйста проверьте файл и введите путь заново");
        }

        str = builderOfStr.toString();

        return str;
    }

    private static void outputAnswer(String answer) {
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

    private static void outputAnswerToConsole(String answer) {
        System.out.println(answer);
    }

    private static void outputAnswerToFile(String answer) {
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
                            writer.write(answer);
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
                        writer.write(answer);
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

    static String answerLine;

    private static void editLine(String line) {
        if (line.contains("AAAA")) {
            line = line.replace("AAAA", "");
            editLine(line);
        } else if (line.contains("ABC")) {
            line = line.replace("ABC", "");
            editLine(line);
        } else if (line.contains("BABA")) {
            line = line.replace("BABA", "BA");
            editLine(line);
        } else {
            answerLine = line;
        }
    }

    public static void main(String[] args) {
        String str;

        printCondition();
        str = inputStr();
        editLine(str);
        outputAnswer(answerLine);
        scan.close();
    }
}