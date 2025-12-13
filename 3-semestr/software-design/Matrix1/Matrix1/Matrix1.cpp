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
    int** matrix = (int**) malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        matrix[i] = (int*) malloc(n * sizeof(int));
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

int main() {
    setlocale(LC_ALL, "Rus");

    printf("Дана матрица M на N.\n");
    int m, n;   //m - rows; n - columns
    printf("Введите m: ");
    scanf("%d", &m);
    printf("Введите n: ");
    scanf("%d", &n);


    int** matrix = createMatrix(m, n);
    int** matrix2 = createMatrix(m, n);
    fillMatrix(matrix, m, n);
    printMatrix(matrix, m, n);
    copyMatrix(matrix2, matrix, m, n);
    
    printf("1. Поменять местами минимальный и максимльный элемент каждого столбца.\n");
    changeMatrix(matrix, m, n);
    printMatrix(matrix, m, n);
     
    printf("2. Поменять местами верхнюю и нижнюю половину.\n");
    swapMatrixHalfs(matrix2, m, n);
    printMatrix(matrix2, m, n);

    destroyMatrix(matrix, m, n);
    destroyMatrix(matrix2, m, n);
    return 0;
}