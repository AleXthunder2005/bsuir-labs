package com.company;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

public class Main {
    private static final Scanner scan = new Scanner(System.in);

    private static void printCondition() {
        System.out.println("Данная программа выведет каждое нечетное слово в кавычках, а каждое четное - в квадратных скобках");
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

    private static String inputText() {
        int choice;
        String text;

        System.out.println("Выберите вариант ввода:");
        System.out.println("1.Ввод из консоли");
        System.out.println("2.Ввод из файла");
        choice = readNum(1, 2);

        if (choice == 1) {
            text = inputTextFromConsole();
        }
        else {
            text = inputTextFromFile();
        }

        return text;
    }

    private static String inputTextFromConsole() {
        String text;
        do {
            System.out.println("Введите текст:");
            text = scan.nextLine();
        } while (text.isBlank());
        text = " " + text + " ";

        return text;
    }

    private static String inputTextFromFile() {
        String pathFile, text;
        boolean isInputFromFileSuccessfully;

        System.out.println("Данные в файле должны содержать текст");
        do {
            System.out.print("Введите путь к файлу и его имя с его раширением:");
            pathFile = scan.nextLine();
            isInputFromFileSuccessfully = checkFile(pathFile);
        } while(!isInputFromFileSuccessfully);

        text = readFile(pathFile);
        text = " " + text + " ";

        return text;
    }

    private static boolean checkFile(String path) {
        String bufText, checkText;
        File checkFile;
        boolean isFileCorrect;
        StringBuilder builderOfText;

        checkFile = new File(path);
        builderOfText = new StringBuilder();
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
                    bufText = fileScan.nextLine();
                    builderOfText.append(bufText);
                }

                checkText = builderOfText.toString();

                if (checkText.isBlank()) {
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
        String bufText, text;
        File file;
        StringBuilder builderOfText;

        file = new File(path);
        builderOfText = new StringBuilder();

        try (Scanner fileScan = new Scanner(file)) {
            do {
                bufText = fileScan.nextLine();
                builderOfText.append(bufText);
                builderOfText.append(' ');
            } while (fileScan.hasNextLine());
        }
        catch (FileNotFoundException e) {
            System.out.println("Файл по данному пути не существует. Пожалуйста проверьте файл и введите путь заново");
        }

        text = builderOfText.toString();

        return text;
    }

    private static int receiveLastSymbIndex(String text) {
        int i;
        char c;
        i = text.length();
        do {
            i--;
            c = text.charAt(i);
        } while ((c == 32) && (i != 0));
        return i;
    }

    private static int receiveNextSpaceIndex(String text, int spaceIndex) {
        int i;
        char c;
        i = spaceIndex;
        do {
            i++;
            c = text.charAt(i);
        } while (c != 32);

        return i;
    }

    private static String createNewWord(String text, int spaceIndex, int numWord) {
        int i, nextSpaceIndex;
        String word;
        char beginSym, endSym;
        StringBuilder builderOfNewWord;

        builderOfNewWord = new StringBuilder();

        do {
            nextSpaceIndex = receiveNextSpaceIndex(text, spaceIndex);
            spaceIndex++;
        } while (nextSpaceIndex - spaceIndex == 0);

        i = spaceIndex;

        if (numWord % 2 == 1) {
            beginSym = '"';
            endSym = '"';
        }
        else {
            beginSym = '[';
            endSym = ']';
        }

        builderOfNewWord.append(beginSym) ;
        do {
            builderOfNewWord.append(text.charAt(i));
            i++;
        } while (i != nextSpaceIndex);
        builderOfNewWord.append(endSym);

        word = builderOfNewWord.toString();
        return word;
    }

    private static String createNewText(String text) {
        int spaceIndex, numWord, lastSpaceIndex;
        String newWord, newText;
        StringBuilder builderOfNewText;

        spaceIndex = 0;
        numWord = 1;
        builderOfNewText = new StringBuilder();
        lastSpaceIndex = receiveLastSymbIndex(text) + 1;

        do {
            while (text.charAt(spaceIndex) == 32) {
                spaceIndex++;
            }
            spaceIndex--;

            newWord = createNewWord(text, spaceIndex, numWord);

            builderOfNewText.append(newWord);
            builderOfNewText.append(' ');

            numWord++;
            spaceIndex = receiveNextSpaceIndex(text, spaceIndex);
        } while (spaceIndex != lastSpaceIndex);

        newText = builderOfNewText.toString();

        return newText;
    }

    private static void outputText(String text) {
        int choice;

        System.out.println("Выберите вариант вывода:");
        System.out.println("1.Вывод в консоль");
        System.out.println("2.Вывод в файл");
        choice = readNum(1, 2);
        scan.close();

        if (choice == 1) {
            outputTextToConsole(text);
        }
        else {
            outputTextToFile(text);
        }
    }

    private static void outputTextToConsole(String text) {
        System.out.print(text);
    }

    private static void outputTextToFile(String text) {
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
                            writer.write(text);
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
                            writer.write(text);
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
        String textIn, newText;

        printCondition();
        textIn = inputText();
        newText = createNewText(textIn);
        outputText(newText);
    }
}
