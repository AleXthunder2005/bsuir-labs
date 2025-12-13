#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <stdlib.h>
#include <locale.h>

typedef struct Node {
    int data;
    struct Node* next;
} Node;

typedef struct Stack {
    Node* top;
} Stack;

// Функция для создания стека
Stack* createStack() {
    Stack* stack = (Stack*)malloc(sizeof(Stack));
    stack->top = NULL;
    return stack;
}

// Проверка, пуст ли стек
int isEmpty(Stack* stack) {
    return stack->top == NULL;
}

// Добавление элемента в стек
void push(Stack* stack, int item) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->data = item;
    newNode->next = stack->top;
    stack->top = newNode;
}

// Удаление элемента из стека
int pop(Stack* stack) {
    if (isEmpty(stack)) {
        printf("Стек пуст\n");
        return -1; // Возвращаем -1, если стек пуст
    }
    Node* temp = stack->top;
    int poppedValue = temp->data;
    stack->top = stack->top->next;
    free(temp);
    return poppedValue;
}

// Получение верхнего элемента стека
int peek(Stack* stack) {
    if (isEmpty(stack)) {
        printf("Стек пуст\n");
        return -1; // Возвращаем -1, если стек пуст
    }
    return stack->top->data;
}

// Функция для слияния двух стеков
void mergeStacks(Stack* stack1, Stack* stack2, Stack* mergedStack) {
    while (!isEmpty(stack1) || !isEmpty(stack2)) {
        int value1 = isEmpty(stack1) ? -1 : peek(stack1);
        int value2 = isEmpty(stack2) ? -1 : peek(stack2);

        if (value1 > value2 || value2 == -1) {
            push(mergedStack, pop(stack1));
        }
        else {
            push(mergedStack, pop(stack2));
        }
    }
}

// Функция для перемещения элементов из одного стека в другой
void transferStack(Stack* sourceStack, Stack* targetStack) {
    while (!isEmpty(sourceStack)) {
        push(targetStack, pop(sourceStack));
    }
}

int main() {
    setlocale(LC_ALL, "RU");
    Stack* stack1 = createStack();
    Stack* stack2 = createStack();
    Stack* mergedStack = createStack();

    int value;

    // Ввод первого стека
    printf("Введите элементы первого стека (для завершения введите -1):\n");
    while (1) {
        scanf("%d", &value);
        if (value == -1) break;
        push(stack1, value);
    }

    // Ввод второго стека
    printf("Введите элементы второго стека (для завершения введите -1):\n");
    while (1) {
        scanf("%d", &value);
        if (value == -1) break;
        push(stack2, value);
    }

    // Слияние стеков
    mergeStacks(stack1, stack2, mergedStack);


    // Вывод элементов финального стека
    printf("Элементы финального стека (возрастающая последовательность):\n");
    while (!isEmpty(mergedStack)) {
        printf("%d ", pop(mergedStack));
    }

    // Освобождение памяти
    free(stack1);
    free(stack2);
    free(mergedStack);

    return 0;
}