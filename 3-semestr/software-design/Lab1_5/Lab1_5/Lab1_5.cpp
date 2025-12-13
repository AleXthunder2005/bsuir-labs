#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <locale.h>
#include <stdlib.h>

int main() {
    setlocale(LC_ALL, "Rus");

    printf("24.Заменить в последовательности n чисел числа большие 7 на число 7 и вывести их количество\n");
    int n;
    printf("Введите n: ");
    scanf("%d", &n);

    int *arr = calloc(4, n);
    int count = 0;

    for (int i = 0; i < n; i++) {
        printf("Введите a[%d]: ", i);
        scanf("%d", &arr[i]);
    }

    printf("Введенный массив: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }

    for (int i = 0; i < n; i++) {
        if (arr[i] > 7) {
            arr[i] = 7;
            count++;
        }
    }

    printf("\nПолученный массив: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
 
    printf("\nКоличество элементов, больших 7: %d", count);

    return 0;
}