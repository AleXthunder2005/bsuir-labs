#include <stdio.h>
#include <string.h>
#include <locale.h>

typedef struct {
    char surname[30];
    char residency[30];
    float average;
} StudentInfo;

void sortStudents(StudentInfo students[], int count) {
    for (int i = 0; i < count - 1; i++) {
        int minIndex = i;
        for (int j = i + 1; j < count; j++) {
            if (strcmp(students[j].surname, students[minIndex].surname) < 0) {
                minIndex = j;
            }
        }

        if (minIndex != i) {
            StudentInfo temp = students[i];
            students[i] = students[minIndex];
            students[minIndex] = temp;
        }
    }
}

int main() {
    setlocale(LC_ALL, "Rus");
    const StudentInfo students[] = {
        {"Салександров", "Минск", 8.5},
        {"Михайлов", "Минск", 7.9},
        {"Ковалев", "Бобруйск", 7.8},
        {"Борисов", "Гомель", 7.2},
        {"Григорьев", "Витебск", 9.1},
        {"Сидоров", "Минск", 8.3},
        {"Егоров", "Могилев", 7.5},
        {"Жуков", "Брест", 8.0},
        {"Зайцев", "Минск", 9.3},
        {"Овчинников", "Солигорск", 9.0},
        {"Иванов", "Слуцк", 6.0},
        {"Ульянов", "Береза", 9.5},
        {"Николаев", "Минск", 8.1},
        {"Петров", "Речица", 6.5},
        {"Харитонов", "Мозырь", 8.2},
        {"Романов", "Рогачев", 7.4},
        {"Тихонов", "Кобрин", 7.0},
        {"Федоров", "Минск", 6.9},
        {"Дмитриев", "Гродно", 6.8},
    };

    printf("Список студентов, проживающих в Минске:\n");
    int studentsCount = sizeof(students) / sizeof(StudentInfo);
    sortStudents(students, studentsCount);
    int minskStudentCount = 0;
    for (int i = 0; i < studentsCount; i++) {
        if (strcmp(students[i].residency, "Минск") == 0) {
            minskStudentCount++;
            printf("%20s, %15s,     %.1f;\n", students[i].surname, students[i].residency, students[i].average);
        }
    }
    printf("\nКоличество студентов из Минска: %d", minskStudentCount);
    return 0;
}