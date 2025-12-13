#pragma once
#include <thread>
#include <mutex>
#include <condition_variable>
#include <queue>
#include <future>
#include <functional>
#include <vector>

class ThreadPool {
private:
    std::vector<std::thread> threads;
    std::queue<std::function<void()>> tasks;
    std::mutex queueMutex;
    std::condition_variable condition;
    bool stop;

public:
    explicit ThreadPool(size_t threadCount = std::thread::hardware_concurrency())
        : stop(false)
    {
        if (threadCount == 0) threadCount = 1;

        for (size_t i = 0; i < threadCount; ++i) {
            //создаем потоки и сразу и передаем им переменную this для того чтобы тело потока имело доступ к полям класса
            threads.emplace_back([this] {
                while (true) {
                    std::function<void()> task;

                    {
                        std::unique_lock<std::mutex> lock(queueMutex); //поток локает мьютекс и код дальше выполняет только 1 поток.
                        //поток засыпает, а когда просыпается то выполняет предикат (появились задачи? остановился пулл?)
                        //когда поток засыпает, он освобождает мьютекс, пока не проснется
                        condition.wait(lock, [this] { return stop || !tasks.empty(); });

                        if (stop && tasks.empty())
                            return;

                        task = std::move(tasks.front());
                        tasks.pop();
                    }

                    task();
                }
                });
        }
    }
    //задача деструктора разбудить все потоки и дождаться их завершения.
    ~ThreadPool() {
        shutdown();
        //если для потока еще не вызывался join, то вызвать, чтобы освободить системные ресурсы, выделенные для потока
        //сам join приостанавливает текущий поток пока выполняется освобождение ресурсов
        for (std::thread& thread : threads)
            if (thread.joinable()) thread.join();
    }

    //шаблонный метод который будет принимать любую функцию (существующую(c именем - lvalue) или временный объект (лямбда например - rvalue)) и аргументы (Args - это набор типов (int, char))
    template <class F, class... Args>
    //метод принимает универсальную ссылку на f (чтобы избежать копирования функции) и универсальную ссылку на аргументы
    //а возвращает объект future с типом возвращаемого результата задачи
    auto enqueue(F&& f, Args&&... args) -> std::future<typename std::result_of<F(Args...)>::type>
    {
        //объявление типа псевдонима
        using return_type = typename std::result_of<F(Args...)>::type;

        //forward - функция-шаблон - передавать аргументы внутрь bind в том виде, как они поступили (lvalue - просто скопировать ссылку, rvalue - переместить а не копировать(как std::move))
        //bind - функция-шаблон - привязывает к функции принимающей аргументы сами аргументы и возвращает callable объект (содержит operator()) и может вызываться без параметров
        //packaged_task - шаблонный класс, который принимает callable и возвращает объект task, и хранит внутри себя callable
        //make_shared превращает это в указатель, потому что объект task некопируемый
        auto task = std::make_shared<std::packaged_task<return_type()>>(std::bind(std::forward<F>(f), std::forward<Args>(args)...));

        //забираем futer с результатом
        std::future<return_type> res = task->get_future();

        {
            std::unique_lock<std::mutex> lock(queueMutex);
            if (stop)
                throw std::runtime_error("ThreadPool is stopped");
            //помещаем в очередь лямбду void(), которая вызывает нашу задачу
            tasks.emplace([task]() { (*task)(); });
        }
        //уведомляем один поток
        condition.notify_one();
        //можем получить результат из объекта future 
        return res;
    }

    void shutdown() {
        {
            //так как потоки читают переменную stop, надо поставить замок перед изменением
            std::unique_lock<std::mutex> lock(queueMutex);
            stop = true;
        }
        //разбудить все потоки, чтобы те завершили бесконечный цикл внутри себя (ОС хранит их статус завершения до тех пор пока для объекта thread не будет вызван join)
        condition.notify_all();
    }
};

