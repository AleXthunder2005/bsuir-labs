package com.epam.rd.autotasks.matrices;
import java.util.Arrays;

public class TransposeMatrix {
    public static int[][] transpose(int[][] matrix) {
        int rows = matrix.length;
        int cols = matrix[0].length;

        // создаём новую матрицу с "перевернутыми" размерами
        int[][] transposed = new int[cols][rows];

        // переносим элементы: matrix[i][j] -> transposed[j][i]
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                transposed[j][i] = matrix[i][j];
            }
        }

        return transposed;
    }

    public static void main(String[] args) {
        System.out.println("Test your code here!\n");

        int[][] matrix = {
                {0, 1, 2},
                {3, 4, 5},
                {6, 7, 8}
        };

        int[][] result = transpose(matrix);
        for (int[] row : result) {
            System.out.println(Arrays.toString(row));
        }
    }
}
