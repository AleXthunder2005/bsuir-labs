#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>
#include <windows.h>

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

bool checkFileData(const string& path, int& n)
{
    const int MIN_N = 1, MAX_N = 10;

    ifstream inputFile;
    bool isIncorrect;

    isIncorrect = false;

    inputFile.open(path);
    inputFile >> n;

    if (inputFile.fail()) {
        inputFile.clear();
        isIncorrect = true;
        cout << "Файл не найден или данные некоректны.\nВнесите изменения в файл и повторите попытку." << endl;
    }

    else if (!inputFile.eof()) {
        cout << "Данные в файле представлены в неправильном формате!\nВнесите изменения в файл и повторите попытку." << endl;
        isIncorrect = true;
        inputFile.clear();
    }

    else if ((MIN_N > n) || (MAX_N < n)) {
        isIncorrect = true;
        cout << "Значение выходит за возможные пределы!\nВнесите изменения в файл и повторите попытку." << endl;
    }

    inputFile.close();
    return isIncorrect;
}

int inputN() {
    const int MIN_N = 1, MAX_N = 10;
    int choice, n;
    bool isFileIncorrect;
    string pathFile;

    cout << "Выберите вариант ввода:" << endl << "1. Ввод из консоли" << endl << "2. Ввод из файла" << endl << "Использовать вариант:";
    choice = getNum(1, 2);

    if (choice == 1) {
        cout << "Введите порядок матрицы от " << MIN_N << " до " << MAX_N << ":";
        n = getNum(MIN_N, MAX_N);
    }
    else {
        cout << "Данные в файле должны содержать натуральное число - порядок матрицы N от " << MIN_N << " до " << MAX_N << endl;
        do {
            cout << "Введите путь к файлу с его раширением:";
            cin >> pathFile;
            isFileIncorrect = checkFileData(pathFile, n);
        } while(isFileIncorrect);
    }
    return n;
}

void fillMatrix(int** matrix, int n) {

    int i, j, counter;

    i = 0;
    counter = 1;

    do {
        if (i % 2 == 0) {
            for (j = 0; j < n; j++){
                matrix[i][j] = counter;
                counter++;
            }
        }
        else {
            for (j = n - 1; j > -1; j--) {
                matrix[i][j] = counter;
                counter++;
            }
        }
        i++;
    } while (i < n);
}


void outputMatrix(int** matrix, int  n) {
    int i, j, choice;
    ofstream outputFile;
    string path;
    bool isFileIncorrect;

    cout << "Выберите вариант вывода:" << endl << "1. Вывод в консоль" << endl << "2. Вывод в файл" << endl << "Использовать вариант:";
    choice = getNum(1, 2);

    if (choice == 1) {
        for (i = 0; i < n; i++) {
            for (j = 0; j < n; j++) {
                cout << setw(4) << matrix[i][j];
            }
            cout << endl;
        }
    }
    else {
        cout << "Для вывода введите путь к файлу и его имя c расширением." << endl;
        cout << "Если файл отсутствует то он будет создан автоматически по указанному пути или в корневой папке программы (по умолчанию)" << endl;
        do {
            cout << "Введите путь:";
            cin >> path;
            outputFile.open(path);
            isFileIncorrect = false;

            for (i = 0; i < n; i++) {
                for (j = 0; j < n; j++) {
                    outputFile << setw(4) << matrix[i][j];
                }
                outputFile << endl;
            }

            if (outputFile.fail()) {
                cout << "Не удалось вывести в файл! ";
                isFileIncorrect = true;
                outputFile.clear();
            }
        } while (isFileIncorrect);

        outputFile.close();
        cout << "Вывод данных... успешно!";
    }
}

int main() {
    int n, i;
    SetConsoleOutputCP(CP_UTF8);

    cout << "Данная программа заполнит матрицу чисел змейкой" << endl;

    n = inputN();

    int** matrix = new int* [n];
    for (i = 0; i < n; i++) {
        matrix[i] = new int[n];
    }

    fillMatrix(matrix, n);
    outputMatrix(matrix, n);
    return 0;
}
