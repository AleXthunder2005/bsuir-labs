package com.company;
import java.util.Scanner;
public class Main {
    public static void main( String[] args ) {
        double  a = 0, b = 0, c = 0, d = 0, e = 0, x1 = 0, x2 = 0, k, m, n, t1, t2, ymax;
        boolean isNotCorrect = true;
        Scanner scan = new Scanner( System.in );
        System.out.println( "Эта программа найдет максимальное значение функции у(x) на промежутке от x1 до x2." );
        do {
            try {
                System.out.print( "Введите коэффициенты a, b, c, d, e: " );
                a = Float.parseFloat( scan.next() );
                b = Float.parseFloat( scan.next() );
                c = Float.parseFloat( scan.next() );
                d = Float.parseFloat( scan.next() );
                e = Float.parseFloat( scan.next() );
                if ( d == 0 && e == 0) {
                    System.out.print( "Ошибка! Деление на 0. " );
                }
                else {
                    isNotCorrect = false;
                }
            }
            catch ( NumberFormatException err ) {
                System.out.print( "Данные были введены некорректно! " );
                scan.nextLine();
            }
        }while ( isNotCorrect );
        isNotCorrect = true;
        do {
            try {
                System.out.print( "Введите x1 и x2: " );
                x1 = Float.parseFloat( scan.next() );
                x2 = Float.parseFloat( scan.next() );
                isNotCorrect = false;
            }
            catch ( NumberFormatException err ) {
                System.out.print( "Данные были введены некорректно! " );
                scan.nextLine();
            }
        } while ( isNotCorrect );
        if ( x2 < x1 ) {
            x1 = x1 + x2;
            x2 = x1 - x2;
            x1 = x1 - x2;
        }
        k = a * d;
        m = 2 * a * e;
        n = e * b - d * c;
        ymax = ( a * x1 * x1 + b * x1 + c ) / ( d * x1 + e );
        if ( ( a * x2 * x2 + b * x2 + c ) / ( d * x2 + e ) > ymax ) {
            ymax = ( a * x2 * x2 + b * x2 + c ) / ( d * x2 + e );
        }
        if ( ( m * m - 4 * k * n ) >= 0 ) {                                         // если D > 0
            t1 = ( -m - Math.sqrt( m * m - 4 * k * n ) ) / ( 2 * k ) ;               // корень 1
            t2 = ( -m + Math.sqrt( m * m - 4 * k * n ) ) / ( 2 * k ) ;                // корень 2
            if ( t1 > x1 && t1 < x2 ) {                                            // если t1 лежит в промежутке
                if ( ( a * t1 * t1 + b * t1 + c ) / ( d * t1 + e ) > ymax ) {       // если y(t1) > ymax
                    ymax = ( a * t1 * t1 + b * t1 + c ) / ( d * t1 + e );            //ymax = y(t1)
                }
            }
            if ( t2 > x1 && t2 < x2 ) {                                               // если t2 лежит в промежутке
                if ( ( a * t2 * t2 + b * t2 + c ) / ( d * t2 + e ) > ymax ) {        // если y(t2) > ymax
                    ymax = ( a * t2 * t2 + b * t2 + c ) / ( d * t2 + e );           // ymax = y(t2)
                }
            }
        }
        System.out.println("Наибольшее значение функции на промежутке: " + Math.round(ymax * 100.0) / 100.0);
    }
}