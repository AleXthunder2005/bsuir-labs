#include <stdio.h>
#include <locale.h>
#include < math.h >

int main() {
    setlocale(LC_ALL, "Rus");

    printf("18.\nа) Вычислить сумму 1/k для 1 <= k <= n\nб) Вычислить сумму 1/(2k+1)^2 для 1 <= k <= n\n");
    double resA = 0;
    double resB = 0;
    
    int n;
    printf("Введите n: ");
    scanf("%d", &n);

    for (int k = 1; k <= n; k++) {
        resA += 1 / double(k);
        resB += 1 / pow(2 * k + 1, 2);
    }
    printf("Результат а): %.8g\nРезультат б): %.8g", resA, resB);
    return 0;
}