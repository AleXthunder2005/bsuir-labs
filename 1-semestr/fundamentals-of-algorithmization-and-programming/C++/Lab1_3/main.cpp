#include <iostream>
#include <windows.h>
#include <cmath>
using namespace std;
int main() {
    SetConsoleOutputCP( CP_UTF8 );
    float a, b, c, d, e, x1, x2, k, m, n, t1, t2, ymax;
    bool isNotCorrect = false;
    cout << "Эта программа найдет максимальное значение функции у(x) на промежутке от x1 до x2." << endl;
    do {
        cout << "Введите коэффициенты a, b, c, d, e:";
        cin >> a >> b >> c >> d >> e;
        if ( cin.fail() ) {
            isNotCorrect = true;
            cout << "Данные были введены некорректно! " << endl;
            cin.clear();
            while ( cin.get() != '\n' );
        }
        else {
            isNotCorrect = false;
        }
        if ( d == 0 && e == 0 ) {
            cout << "Ошибка! Деление на 0. ";
            isNotCorrect = true;
        }
    }while ( isNotCorrect );
    do {
        cout << "Введите x1 и x2:";
        cin >> x1 >> x2;
        if ( cin.fail() ) {
            isNotCorrect = true;
            cout << "Данные были введены некорректно! " << endl;
            cin.clear();
            while ( cin.get() != '\n' );
        }
        else {
            isNotCorrect = false;
        }
    } while ( isNotCorrect );
    if ( x2 < x1 ) {
        x1 = x1 + x2;
        x2 = x1 - x2;
        x1 = x1 - x2;
    }
    k = a * d;
    m = 2 * a * e;
    n = e * b - d * c;
    ymax = ( a * x1 * x1 + b * x1 + c ) / ( d * x1 + e );
    if ( ( a * x2 * x2 + b * x2 + c ) / ( d * x2 + e ) > ymax ) {
        ymax = ( a * x2 * x2 + b * x2 + c ) / ( d * x2 + e );
    }
    if ( ( ( m * m - 4 * k * n ) ) >= 0 ) {
        t1 = ( -m - sqrt(m * m - 4 * k * n ) ) / ( 2 * k );
        t2 = ( -m + sqrt(m * m - 4 * k * n ) ) / ( 2 * k );
        if ( t1 > x1 && t1 < x2 ) {
            if ( ( a * t1 * t1 + b * t1 + c ) / ( d * t1 + e ) > ymax ) {
                ymax = ( a * t1 * t1 + b * t1 + c ) / ( d * t1 + e );
            }
        }
        if( t2 > x1 && t2 < x2 ) {
            if ( ( a * t2 * t2 + b * t2 + c ) / ( d * t2 + e ) > ymax ) {
                ymax = ( a * t2 * t2 + b * t2 + c ) / ( d * t2 + e );
            }
        }
    }
    ymax = round( ymax * 100.0 ) / 100.0;
    cout << "Наибольшее значение функции на промежутке от " << x1 << " " << "до " << x2 << ": " << ymax;
    return 0;
}
