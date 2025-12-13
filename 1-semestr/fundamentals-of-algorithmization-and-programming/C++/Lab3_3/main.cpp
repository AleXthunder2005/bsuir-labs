#include <iostream>
#include <fstream>
#include <string>
#include <windows.h>
using namespace std;

const int MIN_ARR_VALUE = -1000;
const int MAX_ARR_VALUE = 1000;
const int MAX_ARR_LENGTH = 10;
const int MIN_ARR_LENGTH = 1;

void printCondition()
{
    cout << "Данная программа сортирует массив методом простых вставок." << endl;
    cout << "Диапазон значений для длины массива - от " << MIN_ARR_LENGTH << " до " << MAX_ARR_LENGTH << "." << endl;
    cout << "Диапазон значений для элементов массива - от " << MIN_ARR_VALUE << " до " << MAX_ARR_VALUE << "." << endl;
}
int readNum(int min, int max)
{
    bool isIncorrect;
    int num;

    do
    {
        isIncorrect = true;
        cin >> num;
        if (cin.fail() || (cin.get() != '\n'))
        {
            cout << "Некорректный ввод! Введите значение еще раз:" << endl;
            cin.clear();
            while (cin.get() != '\n');
        }
        else
        {
            if (num < min || num > max)
            {
                cout << "Недопустимое значение! Введите значение еще раз:" << endl;
            }
            else
            {
                isIncorrect = false;
            }
        }
    }
    while (isIncorrect);

    return num;
}

int* inputArrFromConsole(int& len) {
    int buf;
    int* arr;
    cout << "Введите количество элементов:" << endl;
    len = readNum(MIN_ARR_LENGTH, MAX_ARR_LENGTH);

    arr = new int[len];

    for (int i = 0; i < len; i++) {
        cout << "Введите элемент последовательности №" << i + 1 << ":" << endl;
        buf = readNum(MIN_ARR_VALUE, MAX_ARR_VALUE);
        arr[i] = buf;
    }
    return arr;
}

bool checkFile(string path) {
    ifstream fin;
    bool isFileCorrect;
    int buf, i, lengthArr;
    int* checkArr;

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

        checkArr = new int[lengthArr];
        i = 0;

        do {
            fin >> buf;
            if (fin.fail()) {
                cout << "Элементы массива введены некорректно!\nВнесите изменения в файл и повторите попытку!" << endl;
                isFileCorrect = false;
                fin.clear();
            }
            else
                checkArr[i] = buf;
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
int* readFile(string path, int& len) {
    ifstream fin;
    int buf;
    int *arr;

    fin.open(path);

    fin >> len;
    arr = new int[len];

    for (int i = 0; i < len; i++)
    {
        fin >> buf;
        arr[i] = buf;
    }

    fin.close();
    return arr;
}
int* inputArrFromFile(int& len)
{
    int* arr;
    string pathFile;
    bool isInputFromFileSuccessfully;

    cout << "Данные в файле должны содержать количество элементов в первой строке и жлементы массива во второй строке" << endl;
    do
    {
        cout << "Введите путь к файлу и его имя с его расширением:";
        cin >> pathFile;
        isInputFromFileSuccessfully = checkFile(pathFile);
    } while(!isInputFromFileSuccessfully);
    arr = readFile(pathFile, len);

    return arr;
}

int* inputArr(int& len)
{
    int choice;
    int* arr;

    cout << "Выберите вариант ввода:" << endl << "1. Ввод из консоли" << endl << "2. Ввод из файла" << endl << "Использовать вариант:";
    choice = readNum(1, 2);

    if (choice == 1)
    {
        arr = inputArrFromConsole(len);
    }
    else
    {
        arr = inputArrFromFile(len);
    }

    return arr;
}
int* sortArr(int* arr, int& len)
{
    int i, j, buf;

    for (i = 1; i < len; i++)
    {
        buf = arr[i];
        j = i;
        while ((j > 0) && (arr[j - 1] > buf))
        {
            arr[j] = arr[j - 1];
            j--;
        }
        arr[j] = buf;
    }
    return arr;
}
void outputArrToConsole(int*& arr, int& len)
{
    for (int i = 0; i < len; i++)
    {
        cout << arr[i] << " ";
    }
}

void outputArrToFile(int*& arr, int& len)
{
    ofstream fout;
    string path;
    bool isFileIncorrect;

    cout << "Для вывода введите путь к файлу и его имя c расширением." << endl;
    cout << "Если файл отсутствует то он будет создан автоматически по указанному пути или в корневой папке программы (по умолчанию)" << endl;
    do
    {
        cout << "Введите путь:";
        cin >> path;
        fout.open(path);
        isFileIncorrect = false;

        for (int i = 0; i < len; i++)
        {
            fout << arr[i] << " ";
        }

        if (fout.fail())
        {
            cout << "Не удалось вывести в файл! ";
            isFileIncorrect = true;
            fout.clear();
        }
    }
    while (isFileIncorrect);

    fout.close();
    cout << "Вывод данных... успешно!";
}

void outputArr(int*& arr, int& len)
{
    int  choice;

    cout << "Выберите вариант вывода:" << endl << "1. Вывод в консоль" << endl << "2. Вывод в файл" << endl << "Использовать вариант:";
    choice = readNum(1, 2);

    if (choice == 1)
    {
        outputArrToConsole(arr, len);
    }
    else
    {
        outputArrToFile(arr, len);
    }
}

int main() {
    int* numArr;
    int lengthArr;

    SetConsoleOutputCP(CP_UTF8);

    printCondition();
    numArr = inputArr(lengthArr);
    numArr = sortArr(numArr, lengthArr);
    outputArr(numArr, lengthArr);
    return 0;
}
