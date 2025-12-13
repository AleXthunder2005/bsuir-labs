import java.io.*;
import java.util.*;

public class Main {
    private static final Scanner scan = new Scanner(System.in);

    private static void printCondition() {
        System.out.println("Данная программа выполнит преобразование списков инцедентностей графа в матрицу смежности.");
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

    private static ArrayList<Integer> inputListFromConsole(int topCount) {
        ArrayList<Integer> list;
        String num;
        int n;
        final int MIN = 1;
        list = new ArrayList<>();

        num = readNum(MIN, topCount);

        while (!num.equals("-")) {
            n = Integer.parseInt(num);
            if (!list.contains(n))
                list.add(n);

            num = readNum(MIN, topCount);
        }

        Collections.sort(list);

        return list;
    }

    private static String inputListFromFile() {
        String pathFile;
        boolean isInputFromFileSuccessfully;

        System.out.println("Данные в файле должны содержать:");
        System.out.println("    количество вершин (число от 1 до 99);");
        System.out.println("    пункт отправления;");
        System.out.println("    пункт прибытия;");
        System.out.println("    элементы списка вершин, связанных с i-ой вершиной, и расстояние до них;");
        System.out.println("    знак '-';");
        System.out.println("    элементы другого i+1-го списка связанных с i+1 вершиной, и расстояние до них;");
        do {
            System.out.print("Введите путь к файлу и его имя с его раширением:");
            pathFile = scan.nextLine();
            isInputFromFileSuccessfully = checkFile(pathFile);
        } while(!isInputFromFileSuccessfully);

        return pathFile;
    }

    private static boolean checkFile(String path) {
        final int MIN = 1, MAX = 99;
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
                        if (tempNum.equals("-")) {
                            isFileCorrect = true;
                        }
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

    private static ArrayList<Integer> readFile (Scanner fileScan) {
        String num;
        ArrayList<Integer> list;

        list = new ArrayList<>();

        num = fileScan.nextLine();

        while (fileScan.hasNextLine() && !num.equals("-")) {
            if (!list.contains(Integer.parseInt(num)))
                list.add(Integer.parseInt(num));
            num = fileScan.nextLine();
            num = fileScan.nextLine();
        }

        if (!num.equals("-")) {
            list.add(Integer.parseInt(num));
        }

        Collections.sort(list);

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

    private static void outputListToConsole(ArrayList<Integer> list) {
        if (!list.isEmpty()) {
            for (Integer num : list) {
                System.out.print(num + " ");
            }
        }
    }

    private static  void outputIncidentLists(ArrayList<Integer>[] incedentLists, int n){
        for (int i = 0; i< n; i++) {
            System.out.print((i+1) + ": ");
            outputListToConsole(incedentLists[i]);
            System.out.println();
        }
    }

    private static void outputAnswerToConsole(int minWay) {
        if (minWay == -1) {
            System.out.println("Между городами нет пути!");
        }
        else {
            System.out.println("Длина кратчайшего пути между городами: " + minWay);
        }
    }


    private static void outputMinWayToFile(int minWay) {
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
                            if (minWay == -1) {
                                writer.write("Между городами нет пути!");
                            }
                            else {
                                writer.write("Длина кратчайшего пути между городами: " + minWay);
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
                        if (minWay == -1) {
                            writer.write("Между городами нет пути!");
                        }
                        else {
                            writer.write("Длина кратчайшего пути между городами: " + minWay);
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

    private static int getEdgeCount (ArrayList<Integer>[] incidentLists){
        int n = incidentLists.length;
        int counter = 0;
        for (int i = 0; i < n; i++) {
            for (Integer dest: incidentLists[i]) {
                counter++;
            }
        }
        return counter;
    }
    private static Edge[] createEdgesArr(ArrayList<Integer>[] incidentLists) {
        int n = incidentLists.length;
        int weight, edgesCount, j = 0;
        Edge[] edges;
        final int MIN = 1, MAX = 99;
        edgesCount = getEdgeCount(incidentLists);
        edges = new Edge[edgesCount];
        for (int i = 0; i < n; i++) {
            for (Integer dest: incidentLists[i]) {
                System.out.println("Введите длину пути из города " + (i+1) + " в город " + dest + ": ");
                weight = Integer.parseInt(readNum(MIN, MAX));
                edges[j] = new Edge(i+1, dest, weight);
                j++;
            }
        }
        return edges;
    }

    private static Edge[] createEdgesArrFromFile(ArrayList<Integer>[] incidentLists, Scanner fileScan) {
        int n = incidentLists.length;
        int weight, edgesCount, j = 0;
        String num;
        Edge[] edges;
        final int MIN = 1, MAX = 99;
        edgesCount = getEdgeCount(incidentLists);
        edges = new Edge[edgesCount];
        num = fileScan.nextLine();
        num = fileScan.nextLine();
        num = fileScan.nextLine();
        for (int i = 0; i < n; i++) {
            for (Integer dest: incidentLists[i]) {
                num = fileScan.nextLine();
                if (num.equals("-")){
                num = fileScan.nextLine();
                }

                num = fileScan.nextLine();
                weight = Integer.parseInt(num);
                edges[j] = new Edge(i+1, dest, weight);
                j++;
            }
        }
        return edges;
    }
    private static int findMinWay(ArrayList<Integer>[] incidentLists, Edge[] edges, int src, int dest) {
        int n = incidentLists.length;

        int[] dist = new int[n];
        for(int i = 0; i < n; i++){
            dist[i] = Integer.MAX_VALUE;
        }
        dist[src-1] = 0;

        for (int i = 0; i < n-1; i++){
            for (int j = 0; j < edges.length; j++){
                if ((dist[edges[j].src - 1] != Integer.MAX_VALUE) && (dist[edges[j].src - 1] + edges[j].weight < dist[edges[j].dest - 1]))
                    dist[edges[j].dest - 1] = dist[edges[j].src - 1] + edges[j].weight;
            }
        }
        if (dist[dest-1] == Integer.MAX_VALUE)
            return -1;
        else
            return dist[dest-1];
    }

    public static class Edge {
        int src;
        int dest;
        int weight;

        public Edge(int src, int dest, int weight) {
            this.src = src;
            this.dest = dest;
            this.weight = weight;
        }
    }

    public static void main(String[] args) throws FileNotFoundException {
        String path;
        int choice, n = 0, src = 0, dest = 0, minWay = 0;
        ArrayList<Integer> tempList;
        File file;
        ArrayList<Integer>[] incidentLists = null;
        Edge[] edges = null;
        int[][] matrix = null;
        final int MIN = 1, MAX = 99;

        printCondition();

        choice = chooseInputListMethod();
        if (choice == 1) {
            System.out.println("Введите количество вершин графа (числа от 1 до 99):");
            n = Integer.parseInt(readNum(MIN, MAX));
            incidentLists = (ArrayList<Integer>[]) new ArrayList[n];

            for (int i = 0; i < n; i++) {
                System.out.println("Введите связанные с вершиной " + (i+1) + " вершины графа, чтобы закончить введите '-':");
                tempList = inputListFromConsole(n);
                incidentLists[i] = tempList;
            }
            System.out.println("Введенный список инцидентностей:");
            outputIncidentLists(incidentLists, n);

            edges = createEdgesArr(incidentLists);

            System.out.println("Введите пункт отправления:");
            src = Integer.parseInt(readNum(MIN, n));
            System.out.println("Введите пункт прибытия:");
            dest = Integer.parseInt(readNum(MIN, n));
        }
        else {
            path = inputListFromFile();
            file = new File(path);
            try (Scanner fileScan = new Scanner(file)) {
                n = Integer.parseInt(fileScan.nextLine());
                src = Integer.parseInt(fileScan.nextLine());
                dest = Integer.parseInt(fileScan.nextLine());
                incidentLists = (ArrayList<Integer>[]) new ArrayList[n];
                int i;
                for (i = 0; (i < n) && (fileScan.hasNextLine()); i++) {
                    tempList = readFile(fileScan);
                    incidentLists[i] = tempList;
                }
                tempList = new ArrayList<>();
                while (i < n) {
                    incidentLists[i] = tempList;
                    i++;
                }
            }
            catch (FileNotFoundException e) {
                System.out.println("Файл по данному пути не существует. Пожалуйста проверьте файл и введите путь заново:");
            }
            try (Scanner fileScan = new Scanner(file)) {
                edges = createEdgesArrFromFile(incidentLists, fileScan);
            }
        }
        minWay = findMinWay(incidentLists, edges, src, dest);

        choice = chooseOutputListMethod();
        if (choice == 1) {
            outputAnswerToConsole(minWay);
        }
        else {
            outputMinWayToFile(minWay);
        }

        scan.close();
    }
}