package com.company;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Iterator;
import java.util.Scanner;

public class Main {

    public static class ListElem implements Iterable<Integer> {
        private static class Node {
           public Integer value;
           public Node next;

           public Node(Integer newValue){
               this.value = newValue;
               this.next = null;
           }
        }
        public Integer size;
        public Node head;

        public ListElem() {
            this.head = null;
            this.size = 0;
        }

        public int size() {
            return size;
        }

        public void insert(Integer newValue) {
            Node newNode = new Node(newValue);
            if (head == null || head.value >= newValue) {
                newNode.next = head;
                head = newNode;
            } else {
                Node current = head;
                while (current.next != null && current.next.value < newValue) {
                    current = current.next;
                }
                newNode.next = current.next;
                current.next = newNode;
            }
            size++;
        }

        public int get(int index) {
            Node current = head;
            for (int i = 0; i < index; i++) {
                current = current.next;
            }
            return current.value;
        }

        public Iterator<Integer> iterator() {
            return new Iterator<>() {
                private Node current = head;

                @Override
                public boolean hasNext() {
                    return current != null;
                }

                @Override
                public Integer next() {
                    Integer value = current.value;
                    current = current.next;
                    return value;
                }
            };
        }
    }

    private static final Scanner scan = new Scanner(System.in);

    private static void printCondition() {
        System.out.println("Данная программа выполнит слияние двух списков в один");
    }

    private static boolean tryConvertStringToInteger (String num, int min, int max) {
        int n;
        boolean isCorrect;

        n = 0;
        isCorrect = true;

        try {
            n = Integer.parseInt(num);
        }
        catch (Exception err) {
            if (!num.equals("-"))
                isCorrect = false;
        }
        if (isCorrect && (n < min || n > max))
            isCorrect = false;

        return isCorrect;
    }

    private static String readNum(int min, int max) {
        boolean isCorrect;
        String num;

        do {
            num = scan.nextLine();
            if (!num.equals("-")) {
                isCorrect = tryConvertStringToInteger(num, min, max);
                if (!isCorrect)
                    System.out.println("Вы ввели некорректные данные! Попробуйте снова:");
            }
            else
                isCorrect = true;
        } while (!isCorrect);

        return num;
    }

    private static int readChoice(){
        int n;
        boolean isCorrect;
        n = 0;
        do {
            isCorrect = true;
            try {
                n = Integer.parseInt(scan.nextLine());
            }
            catch (Exception err) {
                System.out.println("Вы ввели некорректные данные. Попробуйте снова");
                isCorrect = false;
            }
            if (isCorrect && (n < 1 || n > 2)) {
                System.out.println("Введено значение не входящее в диапазон допустимых значений");
                isCorrect = false;
            }
        } while (!isCorrect);
        return n;
    }

    private static int chooseInputListMethod() {
        int choice;

        System.out.println("Выберите вариант ввода:");
        System.out.println("1.Ввод из консоли");
        System.out.println("2.Ввод из файла");
        choice = readChoice();
        return choice;
    }

    private static ListElem inputListFromConsole() {
        ListElem list;
        String num;
        int n;
        final int MIN = -1000000, MAX = 1000000;
        list = new ListElem();

        num = readNum(MIN, MAX);

        while (!num.equals("-")) {
            n = Integer.parseInt(num);
            list.insert(n);

            num = readNum(MIN, MAX);
        }

        return list;
    }

    private static String inputListFromFile() {
        String pathFile;
        boolean isInputFromFileSuccessfully;

        System.out.println("Данные в файле должны содержать элементы списка (числа от -1000000 до 1000000), записанные в отдельных строках, затем знак '-', а затем элементы другого списка");
        do {
            System.out.print("Введите путь к файлу и его имя с его раширением:");
            pathFile = scan.nextLine();
            isInputFromFileSuccessfully = checkFile(pathFile);
        } while(!isInputFromFileSuccessfully);

        return pathFile;
    }

    private static boolean checkFile(String path) {
        final int MIN = -1000000, MAX = 1000000;
        String tempNum;
        File checkFile;
        boolean isFileCorrect;

        tempNum = "";
        checkFile = new File(path);
        isFileCorrect = true;

        if (!checkFile.isFile()) {
            System.out.println("Файл не найден! Пожалуйста проверьте существование файла и введите путь заново:");
            isFileCorrect = false;
        }
        if (isFileCorrect && !checkFile.canRead() ) {
            System.out.println("Файл не может быть прочитан! Пожалуйста проверьте файл и введите путь заново:");
            isFileCorrect = false;
        }

        if (isFileCorrect) {
            try (Scanner fileScan = new Scanner(checkFile)) {

                if (!fileScan.hasNextLine()) {
                    isFileCorrect = false;
                    System.out.println("Файл пустой! Внесите изменения в файл и повторите попытку:");
                }

                if (isFileCorrect) {
                    while (fileScan.hasNextLine() && isFileCorrect) {
                        tempNum = fileScan.nextLine();
                        isFileCorrect = tryConvertStringToInteger(tempNum, MIN, MAX);
                    }

                    if (tempNum.equals("-")) {
                        isFileCorrect = true;

                        while (fileScan.hasNextLine() && isFileCorrect) {
                            tempNum = fileScan.nextLine();
                            isFileCorrect = tryConvertStringToInteger(tempNum, MIN, MAX);
                        }
                        if (tempNum.equals("-"))
                            isFileCorrect = true;
                    }

                    if (!isFileCorrect)
                        System.out.println("Данные в файле некорректны! Внесите изменения и повторите попытку!");
                }
            }
            catch (FileNotFoundException e) {
                System.out.println("Файл по данному пути не существует! Пожалуйста проверьте файл и введите путь заново:");
                isFileCorrect = false;
            }
        }
        return isFileCorrect;
    }

    private static ListElem readFile (Scanner fileScan) {
        String num;
        ListElem list;

        list = new ListElem();

        num = fileScan.nextLine();

        while (fileScan.hasNextLine() && !num.equals("-")) {
            list.insert(Integer.parseInt(num));
            num = fileScan.nextLine();
        }

        if (!num.equals("-")) {
            list.insert(Integer.parseInt(num));
        }

        return list;
    }

    private static int chooseOutputListMethod() {
        int choice;

        System.out.println("Выберите вариант вывода:");
        System.out.println("1.Вывод в консоль");
        System.out.println("2.Вывод в файл");
        choice = readChoice();

        return choice;
    }

    private static void outputListToConsole(ListElem list) {
        if (list.size() > 0) {
            for (Integer num : list) {
                System.out.print(num + " ");
            }
        }
        else {
            System.out.print("Список пуст!");
        }
    }

    private static void outputListToFile(ListElem list) {
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
                            if (list.size() > 0) {
                                for (Integer num : list) {
                                    writer.write(num + " ");
                                }
                            }
                            else {
                                writer.write("Список пуст!");
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
                        if (list.size() > 0) {
                            for (Integer num : list) {
                                writer.write(num + " ");
                            }
                        }
                        else {
                            writer.write("Список пуст!");
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

    private static ListElem mergeLists (ListElem firstList, ListElem secondList){
        ListElem resultList;
        int prev;
        int index;

        resultList = new ListElem();
        prev = 0;

        if (firstList.size() > 0) {
            prev = firstList.get(0);
            resultList.insert(prev);
        }

        for (Integer i: firstList) {
            if (i != prev) {
                resultList.insert(i);
            }
            prev = i;
        }

        index = 0;
        if (resultList.size() > 0) {
            prev = resultList.get(0);
        }
        else
            prev = Integer.MIN_VALUE;


        for (Integer i: secondList) {
            while (index < resultList.size() && i >=  resultList.get(index)){
                index++;
            }
            if (index > 0) {
                prev = resultList.get(index-1);
            }
            if (i != prev) {
                    resultList.insert(i);
            }
        }

        return resultList;
    }

    public static void main(String[] args) {
        String path;
        int choice;
        ListElem firstList, secondList, resultList;
        File file;

        firstList = new ListElem();
        secondList = new ListElem();

        printCondition();

        choice = chooseInputListMethod();
        if (choice == 1) {
            System.out.println("Введите элементы первого списка (числа от -1000000 до 1000000), чтобы закончить введите '-':");
            firstList = inputListFromConsole();
            System.out.println("Введите элементы второго списка (числа от -1000000 до 1000000), чтобы закончить введите '-':");
            secondList = inputListFromConsole();
        }
        else {
            path = inputListFromFile();
            file = new File(path);
            try (Scanner fileScan = new Scanner(file)) {
                firstList = readFile(fileScan);
                if (fileScan.hasNextLine()) {
                    secondList = readFile(fileScan);
                }
            }
            catch (FileNotFoundException e) {
                System.out.println("Файл по данному пути не существует. Пожалуйста проверьте файл и введите путь заново:");
            }
        }

        resultList = mergeLists(firstList, secondList);

        choice = chooseOutputListMethod();
        if (choice == 1) {
            outputListToConsole(resultList);
        }
        else {
            outputListToFile(resultList);
        }

        scan.close();
    }
}