package com.company;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Iterator;
import java.util.NoSuchElementException;
import java.util.Scanner;

public class Main {
    public static class ListElem implements Iterable<Integer> {
        private static class ListNode {
            public Integer value;
            public ListNode next;

            public ListNode(Integer newValue){
                this.value = newValue;
                this.next = null;
            }
        }
        public Integer size;
        public ListNode head;

        public ListElem() {
            this.head = null;
            this.size = 0;
        }

        public void add(Integer newValue) {
            ListNode newNode = new ListNode(newValue);
            if (head == null || head.value >= newValue) {
                newNode.next = head;
                head = newNode;
            } else {
                ListNode current = head;
                while (current.next != null) {
                    current = current.next;
                }
                newNode.next = current.next;
                current.next = newNode;
            }
            size++;
        }

        public Iterator<Integer> iterator() {
            return new Iterator<>() {
                private ListNode current = head;

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
    static Node treeFirst = null;
    static ListElem lastElemlist;
    static ListElem centralElemlist;

    public static void main(String[] args) {
        int choice;
        System.out.println("Программа создаёт бинарное дерево.\n" + "Диапазон значений элементов дерева - от 1 до 99.");
        do {
            choice = menu();
            switch (choice) {
                case 1:
                    System.out.println("Введите элемент, который хотите добавить в дерево (1-99) и 0, чтобы закончить:");
                    int m = inputInt(0, 99);
                    while (m > 0) {
                        System.out.println( "______________________________________________");
                        treeFirst = add(m, treeFirst);
                        printTree(treeFirst, null, true);
                        System.out.println( "______________________________________________");
                        m = inputInt(0, 99);
                    }
                    break;
                case 2:
                    System.out.println("Введите элемент, который хотите удалить из дерева (1-99) и 0, чтобы закончить:");
                    int n = inputInt(0, 99);
                    while (n > 0) {
                        System.out.println( "______________________________________________");
                        treeFirst = delete(n, treeFirst);
                        printTree(treeFirst, null, false);
                        System.out.println( "______________________________________________");
                        n = inputInt(0, 99);
                    }
                    break;
                case 3:
                    int wayLength = findMinWay(treeFirst) - 1;
                    if (wayLength < 1)
                        System.out.println("Невозможно определить минимальный путь! Добавьте вершины дерева и попробуйте еще!");
                    else
                        System.out.println("Длина минимального пути: " + wayLength);
                    break;
                case 4:
                    System.out.println("Дерево до удаления центральных вершин минимальных путей:");
                    System.out.println( "______________________________________________");
                    printTree(treeFirst, null, false);
                    System.out.println( "______________________________________________");

                    int minWayLength = findMinWay(treeFirst);
                    if (minWayLength % 2 == 1) {
                        lastElemlist = new ListElem();
                        centralElemlist = new ListElem();
                        getAllLeafsOnMinWays(treeFirst, minWayLength);
                        for (int value: lastElemlist) {
                            getCentralVertexOnMinWays(treeFirst, value, (minWayLength + 1) / 2);
                        }
                        for (int value: centralElemlist){
                            delete(value, treeFirst);
                        }
                    }

                    System.out.println("Дерево после удаления центральных вершин минимальных путей:");
                    System.out.println( "______________________________________________");
                    printTree(treeFirst, null, false);
                    System.out.println( "______________________________________________");
                    break;
                case 5:
                    boolean isFileIncorrect;
                    String filePath;
                    File inputFile;
                    do {
                        System.out.println("Введите путь к файлу с расширением:");
                        filePath = scan.nextLine();
                        inputFile = new File(filePath);
                        isFileIncorrect = !checkFile(inputFile);
                    } while (isFileIncorrect);
                    inputFromFile(inputFile);
                    printTree(treeFirst, null, false);
                    break;
                case 6:
                    System.out.println("Введите путь к файлу с расширением:");
                    filePath = scan.nextLine();
                    File outputFile = new File(filePath);
                    isFileIncorrect = false;
                    if (!outputFile.isFile()) {
                        System.out.println("Файла по данному пути не существует!");
                                isFileIncorrect = true;
                    }
                    if (!isFileIncorrect && !outputFile.canWrite()) {
                        System.out.println("Файл по данному пути не может быть перезаписан!");
                                isFileIncorrect = true;
                    }
                    if (!isFileIncorrect) {
                        outputInFile(outputFile);
                    }
                    break;
            }
        } while (choice != 7);
        scan.close();
    }

    private static void getAllLeafsOnMinWays(Node treeStart, int minWayLength) {
        if (treeStart != null) {
            if ((minWayLength == 1) && (treeStart.nextLeft == null) && (treeStart.nextRight == null)){
                lastElemlist.add(treeStart.data);
            } else {
                getAllLeafsOnMinWays(treeStart.nextLeft, minWayLength-1);
                getAllLeafsOnMinWays(treeStart.nextRight, minWayLength-1);
            }
        }
    }
    public static boolean hasListThisElem(ListElem list, int elemValue) {
        boolean hasElem = false;
        for (int value: list) {
            if (value == elemValue) {
                hasElem = true;
                break;
            }
        }
        return hasElem;
    }
    private static void getCentralVertexOnMinWays(Node treeStart, final int value, int minWayLength) {
        if (treeStart != null) {
            if ((minWayLength == 1) && !hasListThisElem(centralElemlist, treeStart.data)) {
                centralElemlist.add(treeStart.data);
            } else {
                if (value < treeStart.data)
                    getCentralVertexOnMinWays(treeStart.nextLeft, value, minWayLength-1);
                else
                    getCentralVertexOnMinWays(treeStart.nextRight, value, minWayLength-1);
            }
        }
    }

    public static int inputInt(int min, int max) {
        int num = 0;
        boolean isNotCorrect;
        do {
            isNotCorrect = false;
            try {
                num = Integer.parseInt(scan.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Вы ввели некорректные данные! Попробуйте снова:");
                isNotCorrect = true;
            }
            if (!isNotCorrect && (num < min || num > max)) {
                System.out.println("Введено значение не входящее в диапазон допустимых значений! Попробуйте снова:");
                isNotCorrect = true;
            }
        } while (isNotCorrect);
        return num;
    }

    public static int menu() {
        System.out.print( "\n______________________________________________" +
                "\n1.Добавить элемент в дерево." +
                "\n2.Удалить элемент из дерева." +
                "\n3.Найти длину минимального пути от корня дерева до его листьев." +
                "\n4.Удалить центральные вершины минимальных путей" +
                "\n5.Импортировать дерево из файла." +
                "\n6.Сохранить в файл текущее дерево." +
                "\n7.Закончить." +
                "\n______________________________________________" +
                "\nВведите номер пункта меню: ");
        return inputInt(1, 7);
    }
    public static void showTrunks(Trunk p)
    {
        if (p != null) {
            showTrunks(p.prev);
            System.out.print(p.str);
        }
    }
    public static void printTree(Node root, Trunk prev, boolean isLeft)
    {
        if (root != null) {
            String prev_str = "    ";
            Trunk trunk = new Trunk(prev, prev_str);

            printTree(root.nextRight, trunk, true);

            if (prev == null) {
                trunk.str = "———";
            }
            else if (isLeft) {
                trunk.str = ".———";
                prev_str = "   |";
            }
            else {
                trunk.str = "`———";
                prev.str = prev_str;
            }

            showTrunks(trunk);
            System.out.println(" " + root.data);

            if (prev != null) {
                prev.str = prev_str;
            }
            trunk.str = "   |";

            printTree(root.nextLeft, trunk, false);
        }
    }

    public static void inputFromFile(File file) {
        int n;
        treeFirst = null;
        try (Scanner fileScan = new Scanner(file)) {
            while (fileScan.hasNext()) {
                n = fileScan.nextInt();
                treeFirst = add(n,treeFirst);
            }
        } catch (IOException e) {
            System.out.println("Не удалось считать данные в файле!");
        }
    }

    public static boolean checkFile(File file) {
        final int MIN_VALUE = 1, MAX_VALUE = 99;
        int n;
        boolean isFileCorrect = true;
        if (!file.isFile()) {
            System.out.println("Файла по данному пути не существует!");
            isFileCorrect = false;
        }
        if (isFileCorrect && !file.canRead()) {
            System.out.println("Файл по данному пути не может быть прочитан!");
            isFileCorrect = false;
        }
        if (isFileCorrect) {
            try (Scanner fileScan = new Scanner(file)) {
                while (fileScan.hasNext()){
                    n = fileScan.nextInt();
                    if (n > MAX_VALUE || n < MIN_VALUE) {
                        System.out.println("В файле данные выходят за пределы допустимых значений!");
                        isFileCorrect = false;
                    }
                }
            } catch (FileNotFoundException e) {
                System.out.println("Файл по данному пути не существует!");
                isFileCorrect = false;
            } catch (NoSuchElementException e) {
                System.out.println("В файле данные представлены в неправильном формате!5" +
                        "f");
                isFileCorrect = false;
            }
        }
        return isFileCorrect;
    }

    public static void outputInFile(File outputFile) {
        boolean isFileIncorrect = false;
        String res = treeToString(treeFirst);
        do {
            try {
                if (outputFile.isFile()) {
                    if (outputFile.canWrite()) {
                        try (FileWriter writer = new FileWriter(outputFile)) {
                            if (treeFirst != null) {
                                writer.write(res);
                            } else {
                                writer.write("Пустое дерево\n");
                            }
                        }
                    } else {
                        System.out.println("В файл не возможно записать");
                        isFileIncorrect = true;
                    }
                } else {
                    outputFile.createNewFile();
                    try (FileWriter writer = new FileWriter(outputFile)) {
                        writer.write("Результат:\n");
                        if (treeFirst != null) {
                            writer.write(treeToString(treeFirst));
                        } else {
                            writer.write("Пустое дерево\n");
                        }
                    }
                }
            } catch (IOException e) {
                System.out.println("Не удалось вывести в файл");
            }
        } while (isFileIncorrect);
    }

    public static String treeToString(Node treeStart){
        String ans = "";
        if (treeStart != null){
            ans += treeStart.data + " ";
            ans += treeToString(treeStart.nextLeft);
            ans += treeToString(treeStart.nextRight);
        }
        return ans;
    }

    private static int findMinWay(Node treeStart) {
        if (treeStart == null)
            return 0;
        else if ((treeStart.nextLeft == null) && (treeStart.nextRight == null))
            return 1;
        else if (treeStart.nextLeft == null)
            return 1 + findMinWay(treeStart.nextRight);
        else if (treeStart.nextRight == null)
            return 1 + findMinWay(treeStart.nextLeft);
        else {
            return 1 + Math.min(findMinWay(treeStart.nextLeft), findMinWay(treeStart.nextRight));
        }
    }

    private static Node findMinNodeInRightSubtree (Node startSubtree){
        while (startSubtree.nextLeft != null) {
            startSubtree = startSubtree.nextLeft;
        }
        return startSubtree;
    }

    public static Node delete (int n, Node treeStart) {
        if (treeStart != null) {
            if (treeStart.data == n) {
                if (treeStart.nextRight != null) {
                    if (treeStart.nextLeft == null) {
                        treeStart = treeStart.nextRight;
                    } else {
                        Node temp;
                        temp = findMinNodeInRightSubtree(treeStart.nextRight);
                        treeStart.data = temp.data;
                        treeStart.nextRight = delete(temp.data, treeStart.nextRight);
                    }
                } else if (treeStart.nextLeft != null) {
                    treeStart = treeStart.nextLeft;
                } else {
                    treeStart = null;
                }
            } else {
                if (treeStart.data > n)
                    treeStart.nextLeft = delete(n, treeStart.nextLeft);
                else
                    treeStart.nextRight = delete(n, treeStart.nextRight);
            }
        }
        return treeStart;
    }

    public static Node add(int n, Node treeStart) {
        if (treeStart != null) {
            if (treeStart.data > n) {
                treeStart.nextLeft = add(n, treeStart.nextLeft);
            } else if (treeStart.data < n) {
                treeStart.nextRight = add(n, treeStart.nextRight);
            }
        } else {
            treeStart = new Node(n);
        }
        return treeStart;
    }
}

class Node {
    public int data;
    public Node nextLeft;
    public Node nextRight;

    public Node(int n){
        this.data = n;
        this.nextLeft = null;
        this.nextRight = null;
    }
}

class Trunk {
    Trunk prev;
    String str;

    Trunk(Trunk prev, String str) {
        this.prev = prev;
        this.str = str;
    }
}

