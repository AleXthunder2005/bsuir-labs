#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include <locale.h>
#include <stdlib.h>

typedef struct {
    char *group;
    char *surname;
    int *marks;
} StudentInfo;

#define GROUP_LENGTH 7
#define SURNAME_LENGTH 30
#define MARKS_COUNT 5

StudentInfo parseBuffer(char *buffer) {
    StudentInfo student;
    student.group = (char*)malloc(GROUP_LENGTH * sizeof(char));
    student.surname = (char*)malloc(SURNAME_LENGTH * sizeof(char));
    student.marks = (int*)malloc(MARKS_COUNT * sizeof(int));

    strncpy(student.group, buffer, 6);
    student.group[6] = 0;
    
    int prev = 7;
    int i = 7;
    int length = 0;
    while (buffer[i] != ' ') { i++; length++; }
    strncpy(student.surname, buffer + prev, length);
    student.surname[length] = 0;

    int counter = 0;
    prev = prev + length + 1;
    i = prev;
    while (counter < MARKS_COUNT) {
        while (buffer[i] != ' ' && buffer[i]) i++;

        const int MARK_LENGTH = 2;
        char* strMark = (char*)malloc(MARK_LENGTH * sizeof(char));;
        strncpy(strMark, buffer + prev, i-prev);
        strMark[i - prev] = 0;
        prev = i;

        int mark = atoi(strMark);
        student.marks[counter] = mark;
        counter++;
        i++;
    }

    return student;
}

int calculateDebtCount(int* marks) {
    int i = 0;
    int debtCount = 0;
    const int BAD_MARK = 3;
    while (i < MARKS_COUNT) {
        if (marks[i] <= BAD_MARK) debtCount++;
        i++;
    }

    return debtCount;
}

int main() {
    setlocale(LC_ALL, "Rus");
    const int STUDENT_COUNT = 20;
    int debtCount;
    StudentInfo *students = malloc(STUDENT_COUNT * sizeof(StudentInfo));
    FILE* inputFile = fopen("F:\\Projects\\C Projects\\file 1\\students.txt", "r");
    FILE* outputFile = fopen("F:\\Projects\\C Projects\\file 1\\badStudents.txt", "w");
    char buffer[256];
    printf("Список студентов с задолженностями (количество задолженностей):\n");
    while (fgets(buffer, 256, inputFile) != NULL) {
        StudentInfo currStudent = parseBuffer(buffer);
        debtCount = calculateDebtCount(currStudent.marks);
        if (debtCount > 0) {
            sprintf(buffer, "%s %s %d\n", currStudent.group, currStudent.surname, debtCount);
            fputs(buffer, outputFile);
        }
    }

    fclose(inputFile);
    fclose(outputFile);

    //часть два

    FILE* inputFile2 = fopen("F:\\Projects\\C Projects\\file 1\\input.txt", "r");
    FILE* outputFile2 = fopen("F:\\Projects\\C Projects\\file 1\\output.txt", "w");

    while (fgets(buffer, 256, inputFile2) != NULL) {
        int i = 0;
        int len = strlen(buffer);
        while (buffer[i]) {
            if (buffer[i] == '!') {
                buffer[i] = '.';
            }
            if (buffer[i] == ':') {
                for (int j = len; j > i; j--) {
                    buffer[j + 2] = buffer[j];
                }
                buffer[i] = '.';
                buffer[i + 1] = '.';
                buffer[i + 2] = '.';
                i += 2;
                len += 2;
            }
            i++;
        }

        fputs(buffer, outputFile2);
    }

    fclose(inputFile2);
    fclose(outputFile2);
    return 0;
}