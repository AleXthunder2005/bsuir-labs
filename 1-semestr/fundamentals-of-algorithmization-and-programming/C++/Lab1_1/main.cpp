#include <iostream>
#include <windows.h>
using namespace std;
int main()
{
   SetConsoleOutputCP(CP_UTF8);
    double a, b, c;
    bool isNotCorrect = true;
    cout << "Данная программа найдет наименьшее отношение двух чисел из трех. " << endl;
    do {
        cout << "Введите 3 положительных числа:";
        cin >> a >> b >> c;
        if ( cin.fail() ) {
            cout << "Данные введены некорректно!" << endl;
            cin.clear();
            while ( cin.get() != '\n' );
        }
        else {
            if ( a > 0 && b > 0 && c > 0 ) {
                isNotCorrect = false;
            }
            else {
                cout << "Проверьте корректность данных!" << endl;
            }
        }
    } while ( isNotCorrect );
    double min, max;
    max = a;
    if ( b > max ) {
        max = b;
    }
    if ( c > max ) {
        max = c;
    }
    min = a;
    if ( b < min ) {
        min = b;
    }
    if ( c < min ) {
        min = c;
    }
    cout << "Наименьшее отношение чисел: " << min / max;
    return 0;
}