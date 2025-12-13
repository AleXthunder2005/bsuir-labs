import java.util.NoSuchElementException;
import java.util.Scanner;
import java.io.*;
public class Main {
        private static final Scanner scan = new Scanner(System.in);
        private static int[][] magicSquare;
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
            final int MIN = 3, MAX = 19;
            System.out.println("Данная программа построит магический квадрат нечетного порядка 'методом террас'.");
            System.out.println("Диапазон значений для порядка квадрата - от " + MIN + " до " + MAX + ".");
        }
        private static int inputN() {
            int choice;
            int num;

            System.out.println("Выберите вариант ввода:");
            System.out.println("1.Ввод из консоли");
            System.out.println("2.Ввод из файла");
            choice = readNum(1, 2);

            if (choice == 1) {
                num = inputNFromConsole();
            }
            else {
                num = inputNFromFile();
            }
            return num;
        }
        private static int inputNFromConsole() {
            final int MIN = 3, MAX = 19;
            int num;
            boolean isOdd;
            System.out.println("Порядок магического квадрата (нечётное число от 3 до 19)");
            do {
                num = readNum(MIN, MAX);
                if (num % 2 == 0) {
                    isOdd = false;
                    System.out.println("Число должно быть нечётным!");
                }
                else
                    isOdd = true;
            } while (!isOdd);
            return num;
        }
        private static int inputNFromFile() {
            String pathFile;
            int num;
            boolean isInputFromFileSuccessfully;

            System.out.println("Данные в файле должны содержать gорядок магического квадрата (нечётное число от 3 до 19)");
            do {
                System.out.print("Введите путь к файлу и его имя с его раширением:");
                pathFile = scan.nextLine();
                isInputFromFileSuccessfully = checkFile(pathFile);
            } while(!isInputFromFileSuccessfully);
            num = readFile(pathFile);
            return num;
        }
        private static boolean checkFile(String path){
            final int MIN = 3, MAX = 19;
            int buf;
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
                    buf = fileScan.nextInt();
                    if (buf > MAX || buf < MIN) {
                        System.out.println("В файле данные выходят за пределы допустимых значений. Пожалуйста проверьте файл и введите путь заново");
                        isFileCorrect = false;
                    }
                    if (isFileCorrect && buf % 2 == 0) {
                        isFileCorrect = false;
                        System.out.println("Число должно быть нечётным!");
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
        private static int readFile(String path){
            int num = 0;
            File file;

            file = new File(path);

            try (Scanner fileScan = new Scanner(file)) {
                num = fileScan.nextInt();
            } catch (IOException e) {
                System.out.println("Не удалось прочесть данные в файле!");
            }
            return num;
        }

        private static void outputMagicSquare() {
            int choice;

            System.out.println("Выберите вариант вывода:");
            System.out.println("1.Вывод в консоль");
            System.out.println("2.Вывод в файл");
            choice = readNum(1, 2);

            if (choice == 1) {
                outputMagicSquareToConsole();
            }
            else {
                outputMagicSquareToFile();
            }
        }
        private static void outputMagicSquareToConsole() {
            for (int[] ints : magicSquare) {
                for (int j = 0; j < magicSquare.length; j++) {
                    System.out.print(ints[j] + "  ");
                }
                System.out.println();
            }
        }
        private static void outputMagicSquareToFile() {
            String path;
            boolean isFileIncorrect;

            System.out.println("Введите путь к файлу.");
            System.out.println("Если файл отсутствует, он будет создан автоматически по указанному пути или в корневой папке программы (по умолчанию)");
            do {
                isFileIncorrect = false;
                System.out.print("Введите путь к файлу и его имя c расширением: ");
                path = scan.nextLine();
                File outputFile = new File(path);
                try {
                    if (outputFile.isFile()) {
                        if (outputFile.canWrite()) {
                            try (FileWriter writer = new FileWriter(outputFile)) {
                                for (int i = 0; i < magicSquare.length; i++){
                                    for (int j = 0; j < magicSquare.length; j++) {
                                        writer.write(magicSquare[i][j] + "  ");
                                    }
                                    writer.write('\n');
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
                            for (int i = 0; i < magicSquare.length; i++){
                                for (int j = 0; j < magicSquare.length; j++) {
                                    writer.write(magicSquare[i][j] + "  ");
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

    public static void buildMagicSquare() {
        int n = magicSquare.length;
        int[][] tempMatrix = new int[2*n-1][2*n-1];

        int i = tempMatrix.length / 2;
        int j = 0;
        int counter = 1;

        for (counter = 1; counter <= n * n; counter++) {
            tempMatrix[i][j] = counter;

            if (counter % n == 0) {
                j = counter / n;
                i = tempMatrix.length / 2 + counter / n;
            } else {
                i--;
                j++;
            }
        }
        int delta = n / 2;
        for (int k = delta; k >= 1; k--) {
            int m = k;
            j = n / 2 - (delta - k) - 1;
            i = (tempMatrix.length-1) / 2 - k + 1;

            while (m > 0) {
                tempMatrix[i][(tempMatrix.length-1) - delta - (delta-k)] = tempMatrix[i][j];
                tempMatrix[i][delta + delta-k] = tempMatrix[i][(tempMatrix.length-1) - delta + (delta-k)+1];

                tempMatrix[(tempMatrix.length-1) - delta - (delta-k)][i] = tempMatrix[j][i];
                tempMatrix[delta + delta-k][i] = tempMatrix[(tempMatrix.length-1) - delta + (delta-k)+1][i];

                i += 2;
                m--;
            }
        }

        delta = n / 2;
        for (i = 0; i < magicSquare.length; i++) {
            for (j = 0; j < magicSquare[i].length; j++) {
                magicSquare[i][j] = tempMatrix[i + delta][j + delta];
            }
        }
    }

    public static void main(String[] args) {
        int num;
        printCondition();
        num = inputN();
        magicSquare = new int[num][num];
        buildMagicSquare();
        outputMagicSquare();
        scan.close();
    }
}