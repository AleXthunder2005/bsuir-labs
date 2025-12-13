package com.epam.rd.autotasks;

public class Spiral {

    public static int[][] spiral(int rows, int columns) {
        int[][] result = new int[rows][columns];

        int top = 0, bottom = rows - 1;
        int left = 0, right = columns - 1;

        int num = 1;

        while (top <= bottom && left <= right) {
            // идём слева направо
            for (int j = left; j <= right; j++) {
                result[top][j] = num++;
            }
            top++;

            // идём сверху вниз
            for (int i = top; i <= bottom; i++) {
                result[i][right] = num++;
            }
            right--;

            // идём справа налево
            if (top <= bottom) {
                for (int j = right; j >= left; j--) {
                    result[bottom][j] = num++;
                }
                bottom--;
            }

            // идём снизу вверх
            if (left <= right) {
                for (int i = bottom; i >= top; i--) {
                    result[i][left] = num++;
                }
                left++;
            }
        }

        return result;
    }
}
