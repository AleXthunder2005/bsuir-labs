#include <stdio.h>
#include <locale.h>
#include < math.h >

int main() {
    setlocale(LC_ALL, "Rus");

    printf("17. Вычислить сумму 1/i^3 для 1 <= i <= 50\n");
    long double res = 0;
    for (int i = 1; i <= 50; i++) {
        res += 1 / pow(i, 3);
    }
    printf("Результат: %.8Lg", res);
    return 0;
}