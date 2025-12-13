#include <stdio.h>
#include <locale.h>
#include < math.h >

int main() {
    setlocale(LC_ALL, "Rus");

    printf("13. Вычислить выражение: (1+sin(0.1))(1+sin(0.2))...(1+sin(10))\n");
    long double res = 1 + sin(0.1);
    for (int i = 2; i <= 10/0.1; i++) {
        res *= (1 + sin(0.1 * i));
    }
    printf("Результат: %.8Lg", res);
    return 0;
}