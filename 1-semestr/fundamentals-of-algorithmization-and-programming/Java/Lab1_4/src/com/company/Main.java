package com.company;
import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        double a, b, c, min, max;
        boolean isNotCorrect = true;
        Scanner scan = new Scanner( System.in );
        a = 0;
        b = 0;
        c = 0;
        System.out.println( "Данная программа найдет наименьшее отношение двух чисел из трех." );

        do {
            System.out.println( "Введите 3 положительных числа:" );
            try{
                a = Double.parseDouble( scan.next() );
                b = Double.parseDouble( scan.next() );
                c = Double.parseDouble( scan.nextLine() );
            }
            catch ( NumberFormatException e ){
                System.out.println( "Вы ввели некорректные данные!" );
                scan.nextLine();
            }
            if (a > 0 && b > 0 && c > 0){
                isNotCorrect = false;
            }
        } while (isNotCorrect);
        scan.close();
        max = a;
        if (b > max) {
            max = b;
        }
        if (c > max) {
            max = c;
        }
        min = a;
        if (b < min) {
            min = b;
        }
        if (c < min) {
            min = c;
        }
        System.out.println( "Наименьшее отношение чисел: " + min / max );
    }
}

