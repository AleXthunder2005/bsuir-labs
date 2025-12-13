#pragma once
#include <thread>
#include <mutex>
#include <condition_variable>
#include <queue>
#include <future>
#include <functional>
#include <vector>
#include <stdexcept>

class ThreadPool {
private:
    std::vector<std::thread> threads;
    std::queue<std::function<void()>> tasks;
    std::mutex queueMutex;
    std::condition_variable condition;
    bool stop;

public:
    explicit ThreadPool(size_t threadCount = std::thread::hardware_concurrency());
    ~ThreadPool();

    template <class F, class... Args>
    auto enqueue(F&& f, Args&&... args) -> std::future<typename std::result_of<F(Args...)>::type>
    {
        using return_type = typename std::result_of<F(Args...)>::type;

        auto task = std::make_shared<std::packaged_task<return_type()>>(
            std::bind(std::forward<F>(f), std::forward<Args>(args)...)
        );

        std::future<return_type> res = task->get_future();
        {
            std::unique_lock<std::mutex> lock(queueMutex);
            if (stop)
                throw std::runtime_error("ThreadPool is stopped");
            tasks.emplace([task]() { (*task)(); });
        }
        condition.notify_one();
        return res;
    }

    void shutdown();
};
