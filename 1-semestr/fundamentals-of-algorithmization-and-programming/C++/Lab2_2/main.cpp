#include <iostream>
#include <windows.h>
#include <cmath>
using namespace std;

int getNum(int min, int max) {
    bool isNotCorrect;
    int num;
    do {
        isNotCorrect = true;
        cin >> num;
        if (cin.fail() || (cin.get() != '\n')) {
            cout << "Некорректный ввод! Введите значение еще раз:" << endl;
            cin.clear();
            while (cin.get() != '\n');
        }
        else {
            if (num < min || num > max) {
                cout << "Недопустимое значение! Введите значение еще раз:" << endl;
            }
            else {
                isNotCorrect = false;
            }
        }
    } while (isNotCorrect);
    return num;
}

int getPrimeDivisor(int num) {
    double numRoot;
    int i, primeDivisor;

    numRoot = sqrt(num);
    i = 1;
    do {
        i++;
    } while (num % i != 0 && i < numRoot);

    if (i > numRoot){
        primeDivisor = num;
    }
    else {
        primeDivisor = i;
    }
    return primeDivisor;
}

int main() {
    SetConsoleOutputCP(CP_UTF8);
    const int MIN_P = 2, MAX_P = 10000;
    int p, primeDivisor;

    cout << "Данная программа найдет все простые делители натурального числа P" << endl;

    cout << "Введите натуральное число Р от " << MIN_P << " до " << MAX_P << ":";
    p = getNum(MIN_P, MAX_P);

    do{
        primeDivisor = getPrimeDivisor(p);
        cout << primeDivisor << " ";
        p = p / primeDivisor;
    } while (p != 1);

    return 0;
}
