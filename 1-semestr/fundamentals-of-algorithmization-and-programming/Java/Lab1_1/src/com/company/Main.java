package com.company;
import java.util.Scanner;
public class Main {
    public static void main(String[] args) {

    double a = 0, b = 0, c = 0, min, max;
    boolean isNotCorrect;
    final int MAX_NUM = 1000;

    Scanner scan = new Scanner( System.in );

        System.out.println( "Данная программа найдет наименьшее отношение двух чисел из трех." );

        do {
            isNotCorrect = false;
            System.out.print( "Введите положительное число A < " + MAX_NUM + ": " );
            try {
                a = Double.parseDouble( scan.next() );
            }
            catch (Exception err) {
                System.out.print( "Некорректный ввод! " );
                isNotCorrect = true;
            }
            if (!isNotCorrect && a < 1) {
                System.out.print( "Число должно быть положительным! " );
                isNotCorrect = true;
            }
            if (!isNotCorrect && a > MAX_NUM - 1) {
                System.out.print( "Число должно быть меньше " + MAX_NUM + "! " );
                isNotCorrect = true;
            }
        } while (isNotCorrect);

        do {
            isNotCorrect = false;
            System.out.print( "Введите положительное число B < " + MAX_NUM + ": " );
            try {
                b = Double.parseDouble( scan.next() );
            }
            catch (Exception err) {
                System.out.print( "Некорректный ввод! " );
                isNotCorrect = true;
            }
            if (!isNotCorrect && b < 1) {
                System.out.print( "Число должно быть положительным! " );
                isNotCorrect = true;
            }
            if (!isNotCorrect && b > MAX_NUM - 1) {
                System.out.print( "Число должно быть меньше " + MAX_NUM + "! ");
                isNotCorrect = true;
            }
        } while (isNotCorrect);

        do {
            isNotCorrect = false;
            System.out.print( "Введите положительное число C < " + MAX_NUM + ": " );
            try {
                c = Double.parseDouble( scan.next() );
            }
            catch (Exception err) {
                System.out.print( "Некорректный ввод! " );
                isNotCorrect = true;
            }
            if (!isNotCorrect && c < 1) {
                System.out.print( "Число должно быть положительным! " );
                isNotCorrect = true;
            }
            if (!isNotCorrect && c > MAX_NUM - 1) {
                System.out.print( "Число должно быть меньше " + MAX_NUM + "! " );
                isNotCorrect = true;
            }
        } while (isNotCorrect);

        max = a;
        if ( b > max ) {
            max = b;
        }
        if ( c > max ) {
            max = c;
        }
        min = a;
        if ( b < min ) {
            min = b;
        }
        if ( c < min ) {
            min = c;
        }
        System.out.println( "Наименьшее отношение чисел: " + min / max );
    }
}
