package com.company;

import java.io.*;
import java.util.*;

import static java.lang.Math.round;

public class Main {
    private static final int TYPE_CHOICE_CONTINUE_OR_EXIT = 1;
    private static final int TYPE_CHOICE_FUNCTION = 0;
    private static final int MIN_WARRANTY = 0;
    private static final int MAX_WARRANTY = 1000;
    private static final int MAX_HARDWARE_NAME_LENGTH = 20;
    private static final int MAX_COMPANY_NAME_LENGTH = 20;
    private static final int MAX_DESCRIPTION_LENGTH = 50;
    private static final double MIN_PRICE = 0;
    private static final int MAX_PRICE = 999999;
    private static final Scanner consoleScan = new Scanner(System.in);

    static class hardware {
        String hardwareName;
        String companyName;
        String description;
        int warranty;
        float price;

        public hardware(String hardwareName, String companyName, String description, int warranty, float price) {
            this.hardwareName = hardwareName;
            this.companyName = companyName;
            this.description = description;
            this.warranty = warranty;
            this.price = price;
        }
    }

    static hardware[] listOfHardware = new hardware[1];

    private static void writeTask() {
        System.out.println("--------------------------------------------------------------" +
                "\nДанная программа позволяет вести учёт комплектующих вашего компьютера.");
    }

    private static void print(int typeChoice) {
        if (typeChoice == TYPE_CHOICE_FUNCTION)
            System.out.println("--------------------------------------------------------------\n" +
                    "Выберите действие:\n" +
                    "1 - добавить данные в список комплектующих.\n" +
                    "2 - редактировать данные в списке комплектующих.\n" +
                    "3 - удалить данные из списка комплектующих.\n" +
                    "4 - просмотр данных в списке комплектующих.\n" +
                    "5 - вывод сведений о фирмах-изготовителях комплектующих.\n" +
                    "6 - импорт данных из файла.\n" +
                    "7 - экспорт данных в файл.\n" +
                    "0 - конец работы и выключение программы.\n" +
                    "--------------------------------------------------------------");
        else if (typeChoice == TYPE_CHOICE_CONTINUE_OR_EXIT)
            System.out.println("Повторить действие?\n" +
                    "1 - да.\n" +
                    "2 - нет.");
    }

    private static int inputNumber(int min, int max) {
        int num = 0;
        boolean isNotCorrect;
        do {
            isNotCorrect = false;
            try {
                num = Integer.parseInt(consoleScan.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Вы ввели некорректные данные! Попробуйте еще:");
                isNotCorrect = true;
            }
            if (!isNotCorrect && (num < min || num > max)) {
                System.out.println("Введено значение не входящее в диапазон допустимых! Попробуйте еще:");
                isNotCorrect = true;
            }
        } while (isNotCorrect);
        return num;
    }

    private static boolean checkDataString(String dataString, int maxLength) {
        boolean isIncorrect = false;
        if (dataString.length() > maxLength) {
            isIncorrect = true;
            System.out.println("Вы превысили допустимую длину!");
        }
        if (dataString.isEmpty()) {
            System.out.println("Значение не может быть пустым!");
            isIncorrect = true;
        }
        if (!isIncorrect) {
            for (int i = 0; i < dataString.length() && !isIncorrect; i++) {
                if (dataString.charAt(i) == '@'){
                    isIncorrect = true;
                    System.out.println("Строка не может содержать символ @!");
                }
            }
        }
        return isIncorrect;
    }

    private static String inputHardwareName() {
        String hardwareName;
        boolean isIncorrect;
        do {
            System.out.println("Введите название устройства (до 20 символов):");
            hardwareName = consoleScan.nextLine();
            isIncorrect = checkDataString(hardwareName, MAX_HARDWARE_NAME_LENGTH);
        } while (isIncorrect);
        return hardwareName;
    }

    private static String inputCompanyName() {
        String companyName;
        boolean isIncorrect;
        do {
            System.out.println("Введите название фирмы-изготовителя (до 20 символов):");
            companyName = consoleScan.nextLine();
            isIncorrect = checkDataString(companyName, MAX_COMPANY_NAME_LENGTH);
        } while (isIncorrect);
        return companyName;
    }

    private static String inputDescription() {
        String description;
        boolean isIncorrect;
        do {
            System.out.println("Введите главные характеристики (до 50 символов):");
            description = consoleScan.nextLine();
            isIncorrect = checkDataString(description, MAX_DESCRIPTION_LENGTH);
        } while (isIncorrect);
        return description;
    }

    private static int inputWarranty() {
        int warranty;
        System.out.println("Введите сведения о гарантии (число месяцев от 0 до 1000):");
        warranty = inputNumber(MIN_WARRANTY, MAX_WARRANTY);
        return warranty;
    }

    private static float inputPrice() {
        float price;
        boolean isIncorrect;
        price = 0;
        System.out.println("Введите цену (число BYN от 0 до 999999, копейки от рублей при этом отделяются точкой):");
        do {
            isIncorrect = false;
            try {
                price = Float.parseFloat(consoleScan.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Вы ввели некорректные данные! Попробуйте ещё:");
                isIncorrect = true;
            }
            if (!isIncorrect && (price < MIN_PRICE || price > MAX_PRICE)) {
                System.out.println("Введено значение не входящее в диапазон допустимых! Попробуйте ещё:");
                isIncorrect = true;
            }
        } while (isIncorrect);
        price = (float)round(price * 100) / 100;
        return price;
    }

    private static boolean checkOnSimilarRecord(String hardwareName, String companyName, String description) {
        boolean isEqualRecords = false;
        for (int i = 0; i < listOfHardware.length - 1 && !isEqualRecords; i++)
            isEqualRecords = (hardwareName.equals(listOfHardware[i].hardwareName) && companyName.equals(listOfHardware[i].companyName) && description.equals(listOfHardware[i].description));
        return isEqualRecords;
    }

    private static void takeInfoFromFile() {
        File file;
        String path = enterInputPath();
        String currentString;
        boolean isCorrect;

        file = new File(path);
        try (Scanner fileScan = new Scanner(file)) {
            while (fileScan.hasNextLine()) {
                currentString =  fileScan.nextLine();
                String[] words = currentString.split("@");
                isCorrect = !(checkOnSimilarRecord(words[0], words[1], words[2]));
                if (isCorrect) {
                    saveRecord(words[0], words[1], words[2], Integer.parseInt(words[3]), Float.parseFloat(words[4]));
                } else
                    System.out.println("В файле встречена запись, идентичная уже имеющимся данным!\n" + "Запись импортирована не будет.");
            }
        } catch (Exception e) {
            System.out.println("Проверьте корректность данных в файле!");
        }
    }

    private static String enterOutputPath() {
        String path;
        boolean isFileIncorrect;
        do {
            isFileIncorrect = false;
            System.out.println("Введите путь к файлу:");
            path = consoleScan.nextLine();
            File file = new File(path);

            if (file.isDirectory()) {
                System.out.println("Ошибка! Файл не найден!");
                isFileIncorrect = true;
            }
            else {
                try {
                    if (!file.createNewFile() && !file.canWrite()) {
                        System.out.println("Ошибка! Файл доступен только для чтения!");
                        isFileIncorrect = true;
                    }
                } catch (IOException e) {
                    System.out.println("Ошибка! Не удалось записать информацию в файл!");
                    isFileIncorrect = true;
                }
            }

        } while (isFileIncorrect);
        return path;
    }
    private static String enterInputPath() {
        String path;
        boolean isFileIncorrect;
        do {
            isFileIncorrect = false;
            System.out.println("Введите путь к файлу:");
            path = consoleScan.nextLine();
            File file = new File(path);

            if (!file.isFile()) {
                System.out.println("Файл не найден! Пожалуйста проверьте существование файла и введите путь заново");
                isFileIncorrect = true;
            }
            if (!isFileIncorrect && !file.canRead() ) {
                System.out.println("Файл не может быть прочитан! Пожалуйста проверьте файл и введите путь заново");
                isFileIncorrect = true;
            }
            if (!isFileIncorrect) {
                isFileIncorrect = checkInfInFile(path);
            }
        } while (isFileIncorrect);
        return path;
    }

    private static boolean checkInfInFile(String path) {
        String currentString;
        File checkFile;
        boolean isNotCorrectHardwareName;
        boolean isNotCorrectCompanyName;
        boolean isNotCorrectDescription;
        boolean isNotCorrectWarranty = false;
        boolean isNotCorrectPrice = false;
        boolean isIncorrect = false;

        checkFile = new File(path);

        try (Scanner fileScan = new Scanner(checkFile)) {
            while (fileScan.hasNextLine() && !isIncorrect) {
                currentString = fileScan.nextLine();
                String[] words = currentString.split("@");
                if (words.length > 5) {
                    System.out.println("Некорректные данные! Убедитесь, что поля каждой записи резделены символом '@'.");
                    isIncorrect = true;
                } else {
                    isNotCorrectHardwareName = checkDataString(words[0], MAX_HARDWARE_NAME_LENGTH);
                    isNotCorrectCompanyName = checkDataString(words[1], MAX_COMPANY_NAME_LENGTH);
                    isNotCorrectDescription = checkDataString(words[2], MAX_DESCRIPTION_LENGTH);
                    if ((Integer.parseInt(words[3]) < MIN_WARRANTY) || (Integer.parseInt(words[3]) > MAX_WARRANTY)) {
                        isNotCorrectWarranty = true;
                    }
                    if ((Float.parseFloat(words[4]) < MIN_PRICE) || (Float.parseFloat(words[4]) > MAX_PRICE)) {
                        isNotCorrectPrice = true;
                    }
                    if (isNotCorrectHardwareName || isNotCorrectCompanyName || isNotCorrectDescription || isNotCorrectWarranty || isNotCorrectPrice) {
                        isIncorrect = true;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Проверьте корректность данных в файле!");
            isIncorrect = true;
        }
        return isIncorrect;
    }

    private static void saveRecord(String hardwareName,String companyName, String description, int warranty, float price) {
        listOfHardware[listOfHardware.length - 1] = new hardware(hardwareName, companyName, description, warranty, price);
        listOfHardware = Arrays.copyOf(listOfHardware, listOfHardware.length + 1);
        System.out.println("Запись была добавлена успешно!");
    }

    private static void enterInf() {
        String hardwareName;
        String companyName;
        String description;
        int warranty;
        float price;
        int choice;
        boolean isEqualRecord = false;
        do {
            hardwareName = inputHardwareName();
            companyName = inputCompanyName();
            description = inputDescription();
            if (listOfHardware.length > 1)
                isEqualRecord = checkOnSimilarRecord (hardwareName, companyName, description);
            if (!isEqualRecord) {
                warranty = inputWarranty();
                price = inputPrice();
                saveRecord(hardwareName, companyName, description, warranty, price);
            } else
                System.out.println("Данная запись уже присутствует в списке!");

            print(TYPE_CHOICE_CONTINUE_OR_EXIT);
            choice = inputNumber(1, 2);
        } while (choice != 2);
    }

    private static int inputNumOfRecord(String str) {
        int number;
        final int MIN_NUM = 1;
        lookInf();
        System.out.println("Введите номер записи, которую нужно " + str + ".");
        number = inputNumber(MIN_NUM, listOfHardware.length-1);
        return number - 1;
    }

    private static void correctInf() {
        String hardwareName;
        String companyName;
        String description;
        int warranty;
        float price;
        int choice;
        int numOfRecord;
        do {
            numOfRecord = inputNumOfRecord("изменить");
            hardwareName = inputHardwareName();
            companyName = inputCompanyName();
            description = inputDescription();
            warranty = inputWarranty();
            price = inputPrice();

            listOfHardware[numOfRecord] = new hardware(hardwareName, companyName, description, warranty, price);
            System.out.println("Запись номер " + (numOfRecord + 1) + " была успешно изменена!");

            print(TYPE_CHOICE_CONTINUE_OR_EXIT);
            choice = inputNumber(1, 2);

        } while (choice != 2);
    }

    private static void deleteInf() {
        int numberOfRecord;
        int choice = 0;
        int recordsCount;
        do {
            numberOfRecord = inputNumOfRecord("удалить");
            recordsCount = listOfHardware.length;
            listOfHardware[numberOfRecord] = null;
            for (int i = numberOfRecord+1; i < recordsCount; i++) {
                listOfHardware[i - 1] = listOfHardware[i];
            }
            listOfHardware[recordsCount-1] = null;
            listOfHardware = Arrays.copyOf(listOfHardware, recordsCount - 1);
            System.out.println("Запись номер " + (numberOfRecord + 1) + " была успешно удалена!");

            if (listOfHardware.length == 1) {
                System.out.println("Список записей пуст!");
            } else {
                print(TYPE_CHOICE_CONTINUE_OR_EXIT);
                choice = inputNumber(1, 2);
            }
        } while ((choice != 2) && (listOfHardware.length > 1));
    }

    private static void saveToFile() {
        String path = enterOutputPath();
        try (PrintWriter fileOut = new PrintWriter(path)) {
            for (int i = 0; i < listOfHardware.length - 1; i++)
                fileOut.println(listOfHardware[i].hardwareName + "@" + listOfHardware[i].companyName + "@" + listOfHardware[i].description + "@" + listOfHardware[i].warranty + "@" + listOfHardware[i].price);
        } catch (Exception e) {
            System.out.println("Не удалось вывести в файл!");
        }
        System.out.println("Данные успешно выведены в файл!");
    }

    private static void lookInf() {
        for (int i = 0; i < listOfHardware.length - 1; i++) {
            System.out.println("------------------------------" + "\nЗапись №" + (i + 1) + "\nНазвание устройства: " + listOfHardware[i].hardwareName + "\nФирма-изготовитель: " + listOfHardware[i].companyName+ "\nХарактеристики: " + listOfHardware[i].description + "\nГарантия: " + listOfHardware[i].warranty + " мес" + "\nЦена: " + listOfHardware[i].price + " BYN" + "\n------------------------------");
        }
    }

    private static void lookCompanyInfo(){
        for (int i = 0; i < listOfHardware.length - 1; i++) {
            System.out.println("------------------------------" + "\nЗапись №" + (i + 1) + "\nФирма-изготовитель: " + listOfHardware[i].companyName + "\nНазвание устройства: " + listOfHardware[i].hardwareName + "\nЦена: " + listOfHardware[i].price + " BYN" + "\n------------------------------");
        }
    }
    private static void sortList(){
        int i, k, iMin;
        hardware tempHardware;

        for (k = 0; k < listOfHardware.length - 2; k++) {
            iMin = k;
            for (i = k + 1; i < listOfHardware.length - 1; i++) {
                if (listOfHardware[i].price < listOfHardware[iMin].price){
                    iMin = i;
                }
            }
            tempHardware = listOfHardware[iMin];
            listOfHardware[iMin] = listOfHardware[k];
            listOfHardware[k] = tempHardware;
        }
    }

    private static void workWithCatalog () {
        final int MIN_OPTION = 0, MAX_OPTION = 7;
        int num;
        do {
            print(TYPE_CHOICE_FUNCTION);
            num = inputNumber(MIN_OPTION, MAX_OPTION);
            switch (num) {
                case 1:
                    enterInf();
                    break;
                case 2:
                    if (listOfHardware.length > 1)
                        correctInf();
                    else
                        System.out.println("Для выполнения данного действия необходимо либо ввести, либо импортировать данные.");
                    break;
                case 3:
                    if (listOfHardware.length > 1)
                        deleteInf();
                    else
                        System.out.println("Для выполнения данного действия необходимо либо ввести, либо импортировать данные.");
                    break;
                case 4:
                    if (listOfHardware.length > 1)
                        lookInf();
                    else
                        System.out.println("Для выполнения данного действия необходимо либо ввести, либо импортировать данные.");
                    break;
                case 5:
                    if (listOfHardware.length > 1) {
                        sortList();
                        lookCompanyInfo();
                    } else
                        System.out.println("Для выполнения данного действия необходимо либо ввести, либо импортировать данные.");
                    break;
                case 6:
                    takeInfoFromFile();
                    break;
                case 7:
                    if (listOfHardware.length > 1) {
                        saveToFile();
                    } else
                        System.out.println("Для выполнения данного действия необходимо либо ввести, либо импортировать данные.");
                    break;
            }
        } while (num != 0);
    }
    public static void main (String[]args){
        writeTask();
        workWithCatalog();
        consoleScan.close();
    }
}




