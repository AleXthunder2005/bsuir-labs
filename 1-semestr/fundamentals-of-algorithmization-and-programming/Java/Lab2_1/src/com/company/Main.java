package com.company;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        final int MIN_N = 3, MAX_N = 100, MIN_COORDINATE = -100, MAX_COORDINATE = 100;
        int n, i, x, y, min, max;
        boolean isNotCorrect, areCoordinatesNotUnique, isPointOnPolygon, isPointOnLine, isPointBetweenXCoord, isPointBetweenYCoord ;

        n = 0;
        x = 0;
        y = 0;

        Scanner scan = new Scanner(System.in);
        System.out.println("Данная программа определит, принадлежит ли точка с координатами X и Y многоугольнику");

        System.out.print("Введите количество вершин многоугольника N от " + MIN_N + " до " + MAX_N + ":");
        do {
            isNotCorrect = false;
            try {
                n = Integer.parseInt(scan.nextLine());
            }
            catch (NumberFormatException e) {
                isNotCorrect = true;
                System.out.print("Некорректный ввод! Введите значение еще раз:");
            }
            if ((!isNotCorrect) && (n < MIN_N || n > MAX_N)) {
                isNotCorrect = true;
                System.out.print("Недопустимое значение! Введите значение еще раз:");
            }
        } while (isNotCorrect);

        int[] arrX = new int[n + 1];
        int[] arrY = new int[n + 1];

        System.out.println("Введите координаты точки X и Y");
        System.out.print("Целое значение координаты X от " + MIN_COORDINATE + " до " + MAX_COORDINATE + ":");
        do {
            isNotCorrect = false;
            try {
                x = Integer.parseInt(scan.nextLine());
            }
            catch (NumberFormatException e) {
                isNotCorrect = true;
                System.out.print("Некорректный ввод! Введите значение еще раз:");
            }
            if ((!isNotCorrect) && (x < MIN_COORDINATE || x > MAX_COORDINATE)) {
                isNotCorrect = true;
                System.out.print("Недопустимое значение! Введите значение еще раз:");
            }
        } while (isNotCorrect);

        System.out.print("Целое значение координаты Y от " + MIN_COORDINATE + " до " + MAX_COORDINATE + ":");
        do {
            isNotCorrect = false;
            try {
                y = Integer.parseInt(scan.nextLine());
            }
            catch (NumberFormatException e) {
                isNotCorrect = true;
                System.out.print("Некорректный ввод! Введите значение еще раз:");
            }
            if ((!isNotCorrect) && (y < MIN_COORDINATE || y > MAX_COORDINATE)) {
                isNotCorrect = true;
                System.out.print("Недопустимое значение! Введите значение еще раз:");
            }
        } while (isNotCorrect);

        System.out.println("Последовательно введите координаты X и Y каждой вершины");
        System.out.print("Целое значение координаты X от " + MIN_COORDINATE + " до " + MAX_COORDINATE + ":");
        do {
            isNotCorrect = false;
            try {
                arrX[0] = Integer.parseInt(scan.nextLine());
            }
            catch (NumberFormatException e) {
                isNotCorrect = true;
                System.out.print("Некорректный ввод! Введите значение еще раз:");
            }
            if ((!isNotCorrect) && (arrX[0] < MIN_COORDINATE || arrX[0] > MAX_COORDINATE)) {
                isNotCorrect = true;
                System.out.print("Недопустимое значение! Введите значение еще раз:");
            }
        } while (isNotCorrect);

        System.out.print("Целое значение координаты Y от " + MIN_COORDINATE + " до " + MAX_COORDINATE + ":");
        do {
            isNotCorrect = false;
            try {
                arrY[0] = Integer.parseInt(scan.nextLine());
            }
            catch (NumberFormatException e)  {
                isNotCorrect = true;
                System.out.print("Некорректный ввод! Введите значение еще раз:");
            }
            if ((!isNotCorrect) && (arrY[0] < MIN_COORDINATE || arrY[0] > MAX_COORDINATE)) {
                isNotCorrect = true;
                System.out.print("Недопустимое значение! Введите значение еще раз:");
            }
        } while (isNotCorrect);

        i = 1;
        do {
            System.out.print("Целое значение координаты X от " + MIN_COORDINATE + " до " + MAX_COORDINATE + ":");
            do {
                isNotCorrect = false;
                try {
                    arrX[i] = Integer.parseInt(scan.nextLine());
                }
                catch (NumberFormatException e) {
                    isNotCorrect = true;
                    System.out.print("Некорректный ввод! Введите значение еще раз:");
                }
                if ((!isNotCorrect) && (arrX[i] < MIN_COORDINATE || arrX[i] > MAX_COORDINATE)) {
                    isNotCorrect = true;
                    System.out.print("Недопустимое значение! Введите значение еще раз:");
                }
            } while (isNotCorrect);

            System.out.print("Целое значение координаты Y от " + MIN_COORDINATE + " до " + MAX_COORDINATE + ":");
            do {
                isNotCorrect = false;
                try {
                    arrY[i] = Integer.parseInt(scan.nextLine());
                }
                catch (NumberFormatException e) {
                    isNotCorrect = true;
                    System.out.print("Некорректный ввод! Введите значение еще раз:");
                }
                if ((!isNotCorrect) && (arrY[i] < MIN_COORDINATE || arrY[i] > MAX_COORDINATE)) {
                    isNotCorrect = true;
                    System.out.print("Недопустимое значение! Введите значение еще раз:");
                }
            } while (isNotCorrect);

            areCoordinatesNotUnique = ((arrX[i] == arrX[i-1]) && (arrY[i] == arrY[i-1]));
            if (areCoordinatesNotUnique) {
                System.out.println("Были заданы координаты той же вершины! Введите координаты следующей!");
            }
            else {
                i++;
            }
        } while(i < n);
        scan.close();

        arrX[n] = arrX[0];
        arrY[n] = arrY[0];

        i = 1;
        n++;
        do {
            isPointOnLine = ((y - arrY[i - 1]) * (arrX[i] - arrX[i - 1]) == (arrY[i] - arrY[i - 1]) * (x - arrX[i - 1]));

            if (arrX[i - 1] > arrX[i]) {
                max = arrX[i - 1];
                min = arrX[i];
            }
            else {
                max = arrX[i];
                min = arrX[i - 1];
            }
            isPointBetweenXCoord = ((x >= min) && (x <= max));

            if (arrY[i - 1] > arrY[i]) {
                max = arrX[i - 1];
                min = arrX[i];
            }
            else {
                max = arrY[i];
                min = arrY[i - 1];
            }
            isPointBetweenYCoord = ((y >= min) && (y <= max));

            isPointOnPolygon = (isPointOnLine && isPointBetweenXCoord && isPointBetweenYCoord);
            i++;
        } while ((!isPointOnPolygon) && (i < n));

        if (isPointOnPolygon) {
            System.out.println("Точка находится на одной из сторон многоугольника");
        }
        else {
            System.out.println("Точка не находится ни на одной из сторон многоугольника");
        }
    }
}
