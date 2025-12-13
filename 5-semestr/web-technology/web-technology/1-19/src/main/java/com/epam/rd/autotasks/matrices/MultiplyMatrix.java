package com.epam.rd.autotasks.matrices;
import java.util.Arrays;

public class MultiplyMatrix {
    public static int[][] multiply(int[][] matrix1, int[][] matrix2) {
        int rows1 = matrix1.length;          // количество строк первой матрицы
        int cols1 = matrix1[0].length;       // количество столбцов первой матрицы
        int rows2 = matrix2.length;          // количество строк второй матрицы
        int cols2 = matrix2[0].length;       // количество столбцов второй матрицы

        if (cols1 != rows2) {
            throw new IllegalArgumentException("Количество столбцов первой матрицы должно равняться количеству строк второй матрицы");
        }

        int[][] result = new int[rows1][cols2];

        for (int i = 0; i < rows1; i++) {
            for (int j = 0; j < cols2; j++) {
                int sum = 0;
                for (int k = 0; k < cols1; k++) {
                    sum += matrix1[i][k] * matrix2[k][j];
                }
                result[i][j] = sum;
            }
        }

        return result;
    }

    public static void main(String[] args) {
        System.out.println("Test your code here!\n");

        int[][] a = {
                {1, 2, 3},
                {4, 5, 6}
        };

        int[][] b = {
                {7, 8},
                {9, 10},
                {11, 12}
        };

        int[][] result = multiply(a, b);

        for (int[] row : result) {
            System.out.println(Arrays.toString(row));
        }
    }
}
