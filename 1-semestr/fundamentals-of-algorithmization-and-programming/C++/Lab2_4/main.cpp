#include <iostream>
#include <fstream>
#include <string>
#include <cmath>
#include <windows.h>

using namespace std;

const int
        MIN_ARR_LENGTH = 1,
        MAX_ARR_LENGTH = 20,
        MIN_ARR_VALUE = 1,
        MAX_ARR_VALUE = 100;

void printCondition()
{
    cout << "Дан массив А, состоящий из n-натуральных чисел. Определить максимальное число идущих подряд элементов, равных 1 " << endl;
}
int readNum(int min, int max) {

    bool isIncorrect;
    int num;

    do {
        isIncorrect = true;
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
                isIncorrect = false;
            }
        }
    } while (isIncorrect);

    return num;
}

bool checkFileData(string& path, int*& arr, int& lengthArr) {
    ifstream fin;
    bool isFileCorrect;
    int buf, i;

    fin.open(path);
    isFileCorrect = true;

    fin >> lengthArr;
    if (fin.fail()) {
        fin.clear();
        isFileCorrect = false;
        cout << "Файл не найден или данные некоректны.\nВнесите изменения в файл и повторите попытку!" << endl;
    }

    else if ((MIN_ARR_LENGTH > lengthArr) || (MAX_ARR_LENGTH < lengthArr)) {
        isFileCorrect = false;
        cout << "Значение выходит за возможные пределы!\nВнесите изменения в файл и повторите попытку!" << endl;
    }
    if (isFileCorrect) {

        arr = new int[lengthArr];
        i = 0;

        do {
            fin >> buf;
            if (fin.fail()) {
                cout << "Элементы массива введены некорректно!\nВнесите изменения в файл и повторите попытку!" << endl;
                isFileCorrect = false;
                fin.clear();
            }
            else
                arr[i] = buf;
            i++;
        } while (isFileCorrect && i < lengthArr);
    }

    if (isFileCorrect && !fin.eof()) {
        cout << "Элементы массива введены некорректно!\nВнесите изменения в файл и повторите попытку!" << endl;
        isFileCorrect = false;
    }

    fin.close();
    return isFileCorrect;
}

void inputArrFromConsole(int*& arr, int& lengthArr) {
    int buf;
    cout << "Введите количество элементов:" << endl;
    lengthArr = readNum(MIN_ARR_LENGTH, MAX_ARR_LENGTH);

    arr = new int[lengthArr];

    for (int i = 0; i < lengthArr; i++) {
        cout << "Введите элемент последовательности №" << i + 1 << ":" << endl;
        buf = readNum(MIN_ARR_VALUE, MAX_ARR_VALUE);
        arr[i] = buf;
    }
}
void inputArray(int*& arr, int& lengthArr) {
    int choice;
    bool isInputFromFileSuccessfully;
    string pathFile;

    cout << "Выберите вариант ввода:" << endl << "1. Ввод из консоли" << endl << "2. Ввод из файла" << endl << "Использовать вариант:";
    choice = readNum(1, 2);

    if (choice == 1) {
        cout << "Допустимые значения:" << endl;
        cout << "Количество элементов - натуральное число от " << MIN_ARR_LENGTH << " до " << MAX_ARR_LENGTH << endl;
        cout << "Элементы массива - натуральные числа от " << MIN_ARR_VALUE << " до " << MAX_ARR_VALUE << endl;
        inputArrFromConsole(arr, lengthArr);
    }
    else {
        cout << "Данные в файле должны содержать:" << endl;
        cout << "Количество элементов - натуральное число от " << MIN_ARR_LENGTH << " до " << MAX_ARR_LENGTH << endl;
        cout << "Элементы массива - натуральные числа от " << MIN_ARR_VALUE << " до " << MAX_ARR_VALUE << endl;

        do {
            cout << "Введите путь к файлу с его раширением:";
            cin >> pathFile;
            isInputFromFileSuccessfully = checkFileData(pathFile, arr, lengthArr);
        } while(!isInputFromFileSuccessfully);
    }
}

void outputData(int count) {
    int  choice;
    ofstream fout;
    string path;
    bool isFileIncorrect;

    cout << "Выберите вариант вывода:" << endl << "1. Вывод в консоль" << endl << "2. Вывод в файл" << endl << "Использовать вариант:";
    choice = readNum(1, 2);

    if (choice == 1) {
        if (count == 0) {
            cout << "Среди элементов массива чисел равных 1 нет";
        }
        else {
            cout << "Максимальное количество  подряд идущих чисел равных 1 в массиве: " << count;
        }
    }
    else {
        cout << "Для вывода введите путь к файлу и его имя c расширением." << endl;
        cout << "Если файл отсутствует то он будет создан автоматически по указанному пути или в корневой папке программы (по умолчанию)" << endl;
        do {
            cout << "Введите путь:";
            cin >> path;
            fout.open(path);
            isFileIncorrect = false;

            if (count == 0) {
                fout << "Среди элементов массива чисел равных 1 нет";
            }
            else {
                fout << "Максимальное количество  подряд идущих чисел равных 1 в массиве: " << count;
            }

            if (fout.fail()) {
                cout << "Не удалось вывести в файл! ";
                isFileIncorrect = true;
                fout.clear();
            }
        } while (isFileIncorrect);

        fout.close();
        cout << "Вывод данных... успешно!";
    }
}
int solveTheTask(int* arr, int n)
{
    int i;
    int count;
    int maxCount;

    count = 0;
    maxCount = 0;
    for (i = 0; i < n; i++)
    {
        if (arr[i] == 1)
        {
        count++;
        if (count > maxCount)
            maxCount = count;
        }
        else
            count = 0;

    }
    delete [] arr;
    return maxCount;

}
int main() {
    int maxCount, lengthArr;
    int* arrA = new int;

    SetConsoleOutputCP(CP_UTF8);

    printCondition();
    inputArray(arrA, lengthArr);
    maxCount = solveTheTask(arrA, lengthArr);
    outputData(maxCount);

    return 0;
}