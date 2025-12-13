#include "pch.h"
#include "ThreadPool.h"


ThreadPool::ThreadPool(size_t threadCount)
    : stop(false)
{
    if (threadCount == 0) threadCount = 1;

    for (size_t i = 0; i < threadCount; ++i) {
        threads.emplace_back([this] {
            while (true) {
                std::function<void()> task;
                {
                    std::unique_lock<std::mutex> lock(queueMutex);
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

ThreadPool::~ThreadPool() {
    shutdown();
    for (std::thread& thread : threads)
        if (thread.joinable()) thread.join();
}

void ThreadPool::shutdown() {
    {
        std::unique_lock<std::mutex> lock(queueMutex);
        stop = true;
    }
    condition.notify_all();
}
