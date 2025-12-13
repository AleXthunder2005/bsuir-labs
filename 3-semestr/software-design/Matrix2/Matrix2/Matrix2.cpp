#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <locale.h>
#include <stdlib.h>

void printMatrix(int** matrix, int N, int M)
{
    printf("\n");
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            printf("%*d", 5, matrix[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

int** createMatrix(int m, int n)
{
    int** matrix = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        matrix[i] = (int*)malloc(n * sizeof(int));
    }
    return matrix;
}

void fillMatrix(int** matrix, int m, int n) {
    const MAX = 100;
    const MIN = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            matrix[i][j] = rand() % MAX;
        }
    }
}

void changeMatrix(int** matrix, int m, int n) {
    int iMin, iMax;
    int temp;
    for (int j = 0; j < n; j++) {
        iMin = 0;
        iMax = 0;
        for (int i = 1; i < m; i++) {
            if (matrix[i][j] < matrix[iMin][j]) iMin = i;
            if (matrix[i][j] > matrix[iMax][j]) iMax = i;
        }
        temp = matrix[iMax][j];
        matrix[iMax][j] = matrix[iMin][j];
        matrix[iMin][j] = temp;
    }
}

void destroyMatrix(int** matrix, int m)
{
    for (int i = 0; i < m; i++) {
        free(matrix[i]);
    }
    free(matrix);
}

void swapMatrixHalfs(int** matrix, int m, int n) {
    int midI = m / 2;
    int temp;
    for (int i = 0; i < midI; i++) {
        for (int j = 0; j < n; j++) {
            temp = matrix[i][j];
            matrix[i][j] = matrix[midI + i + (m % 2)][j];
            matrix[midI + i + (m % 2)][j] = temp;
        }
    }
}

void copyMatrix(int** matrixDest, int** matrixSrc, int m, int n) {
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            matrixDest[i][j] = matrixSrc[i][j];
        }
    }
}

int findMinInHorizontalQuart(int** matrix, int n) {
    int i, j, min;
    min = 101;
    for (i = 0; i < n; i++) {
        for (j = 0; ((j < i) && (j + i < n - 1)); j++) {
            if (matrix[i][j] < min) min = matrix[i][j];
            if (matrix[i][n - j - 1] < min) min = matrix[i][n - j - 1];
        }
    }
    return min;
}

int findMinInUpQuart(int** matrix, int n) {
    int i, j, jCurr, min;
    min = 101;

    jCurr = 0;
    while (jCurr < n) {
        i = 0;
        j = jCurr;
        while ((j > i) && (i + j < n - 1)) {
            if (matrix[i][j] < min) min = matrix[i][j];
            i++;
            j--;
        }
        jCurr++;
    }
    return min;
}

int main() {
    setlocale(LC_ALL, "Rus");
    srand(time(NULL));

    printf("Дана матрица M на N.\n");
    int n;   //m - rows; n - columns
    printf("Введите n: ");
    scanf("%d", &n);


    int** matrix = createMatrix(n, n);
    int** matrix2 = createMatrix(n, n);
    fillMatrix(matrix, n, n);
    printMatrix(matrix, n, n);

    printf("1. Найти минимальный элемент в левой и правой четверти матрицы (без учёта диагоналей).\n");
    printf("%d\n", findMinInHorizontalQuart(matrix, n));

    printf("2. Найти минимальный элемент в верхней четверти матрицы (без учёта диагоналей).\n");
    printf("%d\n", findMinInUpQuart(matrix, n));

    destroyMatrix(matrix, n, n);
    destroyMatrix(matrix2, n, n);
    return 0;
}