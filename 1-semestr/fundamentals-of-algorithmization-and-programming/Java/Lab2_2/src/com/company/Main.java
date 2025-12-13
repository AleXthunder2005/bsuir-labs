package com.company;
import java.util.Scanner;

public class Main {
    public static int getNum(int min, int max) {
        boolean isNotCorrect;
        int num;

        Scanner scan = new Scanner(System.in);
        num = 0;

        do {
            isNotCorrect = false;
            try {
                num = Integer.parseInt(scan.nextLine());
            }
            catch (NumberFormatException e) {
                isNotCorrect = true;
                System.out.print("Некорректный ввод! Введите значение еще раз:" );
            }
            if ((!isNotCorrect) && (num < min || num > max)) {
                isNotCorrect = true;
                System.out.print("Недопустимое значение! Введите значение еще раз:");
            }
        } while (isNotCorrect);

        scan.close();
        return num;
    }
    public static int getPrimeDivisor(int num) {
        double numRoot;
        int i, primeDivisor;

        numRoot = Math.sqrt(num);
        i = 1;
        do {
            i++;
        } while (num % i != 0 && i < numRoot);

        if (i > numRoot){
            primeDivisor = num;
        }
        else {
            primeDivisor = i;
        }
        return primeDivisor;
    }

    public static void main(String[] args) {
	final int MIN_P = 2, MAX_P = 10000;
        int p, primeDivisor;

        System.out.println("Данная программа найдет все простые делители натурального числа P");

        System.out.print("Введите натуральное число Р от " + MIN_P + " до " + MAX_P + ":");
        p = getNum(MIN_P, MAX_P);

        do{
            primeDivisor = getPrimeDivisor(p);
            System.out.print(primeDivisor + " ");
            p = p / primeDivisor;
        } while (p != 1);
    }
}
