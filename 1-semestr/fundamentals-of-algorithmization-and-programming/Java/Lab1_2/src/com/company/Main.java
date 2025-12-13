package com.company;
import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        int n = 0, fact = 1;
        double sum = 0;
        boolean isNotCorrect = true;
        Scanner scan = new Scanner( System.in );
        System.out.println( "Данная программа вычислит сумму 1/I! от I = 1 до I = N " );
        do {
            try {
                System.out.println( "Введите натуральное число N не большее 12: " );
                n = Integer.parseInt( scan.next() );
                if ( n > 0 && n < 13) {
                    isNotCorrect = false;
                }
                else {
                    System.out.print( "Некорректные данные! " );
                }
            }
            catch ( NumberFormatException e ) {
                System.out.print( "Проверьте корректность данных! " );
            }
        }while ( isNotCorrect );
        for ( int i = 1; i < n + 1; i = i + 1 ) {
            fact *= i;
            sum += (double) 1 / fact;
        }
        System.out.println( "Сумма равна " + sum );
    }
}
