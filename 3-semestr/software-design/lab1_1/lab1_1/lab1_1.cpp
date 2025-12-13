#include <stdio.h>
#include <locale.h>

int main() {
    setlocale(LC_ALL, "Rus");

    printf("Данная программа для любого введенного натурального числа n до 1023 вычислит 2^n.\nВведите n:");
    int n;
    scanf("%d", &n);
    long double res = 1;
    for (int i = 1; i <= n; i++) {
        res = res * 2;
    }
    printf("Результат: %.0Lf", res);
    return 0;
}