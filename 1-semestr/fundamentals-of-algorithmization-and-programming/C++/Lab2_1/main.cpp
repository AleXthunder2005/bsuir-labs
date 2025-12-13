#include <iostream>
#include <windows.h>

using namespace std;

int main() {
    SetConsoleOutputCP(CP_UTF8);
    const int MIN_N = 3, MAX_N = 100, MIN_COORDINATE = -100, MAX_COORDINATE = 100;
    int n, i, x, y, min, max;
    bool isNotCorrect, areCoordinatesNotUnique, isPointOnPolygon, isPointOnLine, isPointBetweenXCoord, isPointBetweenYCoord ;

    cout << "Данная программа определит, находится ли точка с координатами X и Y на стороне многоугольника" << endl;

    cout << "Введите количество вершин многоугольника N от " << MIN_N << " до " << MAX_N << ":";
    do {
        isNotCorrect = true;
        cin >> n;
        if (cin.fail() || (cin.get() != '\n')) {
            cout << "Некорректный ввод! Введите значение еще раз:" << endl;
            cin.clear();
            while (cin.get() != '\n');
        }
        else {
            if (n < MIN_N || n > MAX_N) {
                cout << "Недопустимое значение! Введите значение еще раз:" << endl;
            }
            else {
                isNotCorrect = false;
            }
        }
    } while (isNotCorrect);

    int* arrX = new int[n + 1];
    int* arrY = new int[n + 1];

    cout << "Введите координаты точки X и Y" << endl;
    cout << "Целое значение координаты X от " << MIN_COORDINATE << " до " << MAX_COORDINATE << ":";
    do {
        isNotCorrect = true;
        cin >> x;
        if (cin.fail() || (cin.get() != '\n')) {
            cout << "Некорректный ввод! Введите значение еще раз:" << endl;
            cin.clear();
            while (cin.get() != '\n');
        }
        else {
            if (x < MIN_COORDINATE || x > MAX_COORDINATE) {
                cout << "Недопустимое значение! Введите значение еще раз:" << endl;
            }
            else {
                isNotCorrect = false;
            }
        }
    } while (isNotCorrect);

    cout << "Целое значение координаты Y от " << MIN_COORDINATE << " до " << MAX_COORDINATE << ":";
    do {
        isNotCorrect = true;
        cin >> y;
        if (cin.fail() || (cin.get() != '\n')) {
            cout << "Некорректный ввод! Введите значение еще раз:" << endl;
            cin.clear();
            while (cin.get() != '\n');
        }
        else {
            if (y < MIN_COORDINATE || y > MAX_COORDINATE) {
                cout << "Недопустимое значение! Введите значение еще раз:" << endl;
            }
            else {
                isNotCorrect = false;
            }
        }
    } while (isNotCorrect);

    cout << "Последовательно введите координаты X и Y каждой вершины" << endl;
    cout << "Целое значение координаты X от " << MIN_COORDINATE << " до " << MAX_COORDINATE << ":";
    do {
        isNotCorrect = true;
        cin >> arrX[0];
        if (cin.fail() || (cin.get() != '\n')) {
            cout << "Некорректный ввод! Введите значение еще раз:" << endl;
            cin.clear();
            while (cin.get() != '\n');
        }
        else {
            if (arrX[0] < MIN_COORDINATE || arrX[0] > MAX_COORDINATE) {
                cout << "Недопустимое значение! Введите значение еще раз:" << endl;
            }
            else {
                isNotCorrect = false;
            }
        }
    } while (isNotCorrect);

    cout << "Целое значение координаты Y от " << MIN_COORDINATE << " до " << MAX_COORDINATE << ":";
    do {
        isNotCorrect = true;
        cin >> arrY[0];
        if (cin.fail() || (cin.get() != '\n')) {
            cout << "Некорректный ввод! Введите значение еще раз:" << endl;
            cin.clear();
            while (cin.get() != '\n');
        }
        else {
            if (arrY[0] < MIN_COORDINATE || arrY[0] > MAX_COORDINATE) {
                cout << "Недопустимое значение! Введите значение еще раз:" << endl;
            }
            else {
                isNotCorrect = false;
            }
        }
    } while (isNotCorrect);

    i = 1;
    do {
        cout << "Целое значение координаты X от " << MIN_COORDINATE << " до " << MAX_COORDINATE << ":";
        do {
            isNotCorrect = true;
            cin >> arrX[i];
            if (cin.fail() || (cin.get() != '\n')) {
                cout << "Некорректный ввод! Введите значение еще раз:" << endl;
                cin.clear();
                while (cin.get() != '\n');
            }
            else {
                if (arrX[i] < MIN_COORDINATE || arrX[i] > MAX_COORDINATE) {
                    cout << "Недопустимое значение! Введите значение еще раз:" << endl;
                }
                else {
                    isNotCorrect = false;
                }
            }
        } while (isNotCorrect);

        cout << "Целое значение координаты Y от " << MIN_COORDINATE << " до " << MAX_COORDINATE << ":";
        do {
            isNotCorrect = true;
            cin >> arrY[i];
            if (cin.fail() || (cin.get() != '\n')) {
                cout << "Некорректный ввод! Введите значение еще раз:" << endl;
                cin.clear();
                while (cin.get() != '\n');
            }
            else {
                if (arrY[i] < MIN_COORDINATE || arrY[i] > MAX_COORDINATE) {
                    cout << "Недопустимое значение! Введите значение еще раз:" << endl;
                }
                else {
                    isNotCorrect = false;
                }
            }
        } while (isNotCorrect);
        areCoordinatesNotUnique = ((arrX[i] == arrX[i-1]) && (arrY[i] == arrY[i-1]));
        if (areCoordinatesNotUnique) {
            cout << "Были заданы координаты той же вершины! Введите координаты следующей!" << endl;
        }
        else {
            i++;
        }
    } while(i < n);

    arrX[n] = arrX[0];
    arrY[n] = arrY[0];

    n++;
    i = 1;
    do {
        isPointOnLine = ((y - arrY[i - 1]) * (arrX[i] - arrX[i - 1]) == (arrY[i] - arrY[i - 1]) * (x - arrX[i - 1]));

        if (arrX[i - 1] > arrX[i]) {
            max = arrX[i - 1];
            min = arrX[i];
        }
        else {
            max = arrX[i];
            min = arrX[i - 1];
        }
        isPointBetweenXCoord = ((x >= min) && (x <= max));

        if (arrY[i - 1] > arrY[i]) {
            max = arrX[i - 1];
            min = arrX[i];
        }
        else {
            max = arrY[i];
            min = arrY[i - 1];
        }
        isPointBetweenYCoord = ((y >= min) && (y <= max));

        isPointOnPolygon = (isPointOnLine && isPointBetweenXCoord && isPointBetweenYCoord);
        i++;
    } while ( (!isPointOnPolygon) && (i < n) );

    if (isPointOnPolygon)
    {
        cout << "Точка находится на одной из сторон многоугольника";
    }
    else {
        cout << "Точка не находится ни на одной из сторон многоугольника";
    }
    return 0;
}
