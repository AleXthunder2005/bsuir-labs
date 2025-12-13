#include <iostream>
#include <windows.h>
using namespace std;
int main()
{
    SetConsoleOutputCP(CP_UTF8);
    int n, fact = 1;
    double sum = 0;
    bool isNotCorrect = true;
    cout << "Данная программа вычислит сумму 1/I! от I = 1 до I = N " << endl;
    do {
        cout << "Введите натуральное число N, не большее 12:" << endl;
        cin >> n;
        if ( cin.fail() ) {
            cout << "Проверьте корректность данных! ";
            cin.clear();
            while ( cin.get() != '\n' );
        }
        else {
            if ( n > 0 && n < 13) {
                isNotCorrect = false;
            }
            else {
                cout << "Некорректные данные! ";
                isNotCorrect = true;
            }
        }
    } while ( isNotCorrect );

    for ( int i = 1; i < n + 1; i++ ) {
        fact *= i;
        sum += ( double ) 1 / fact;
    }
    cout << "Сумма равна " << sum;
    return 0;
}
