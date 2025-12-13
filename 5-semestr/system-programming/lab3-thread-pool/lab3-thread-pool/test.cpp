#include <iostream>
#include <vector>
#include <future>
#include "threadpool.h"

int main() {
    ThreadPool pool(4); // 4 рабочих потока
    std::vector<std::future<int>> results;

    // добавляем 10 задач по выводу квадрата номера задачи
    for (int i = 0; i < 10; ++i) {
        results.push_back(pool.enqueue([i]() {
                std::cout << "Task " << i << " running in thread " << std::this_thread::get_id() << "\n";
                return i * i;
            })
        );
    }

    // выводим результаты
    for (auto& fut : results) {
        std::cout << "Result: " << fut.get() << "\n";
    }

    std::cout << "All tasks finished.\n";
    return 0;
}
