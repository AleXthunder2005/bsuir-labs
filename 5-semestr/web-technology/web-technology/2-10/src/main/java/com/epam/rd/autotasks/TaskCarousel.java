package com.epam.rd.autotasks;

import java.util.ArrayList;
import java.util.List;

public class TaskCarousel {
    private final List<Task> tasks;
    private final int capacity;
    private int currentIndex = 0;

    public TaskCarousel(int capacity) {
        this.capacity = capacity;
        this.tasks = new ArrayList<>();
    }

    public boolean addTask(Task task) {
        if (task == null || task.isFinished() || isFull()) {
            return false;
        }
        return tasks.add(task);
    }

    public boolean execute() {
        if (tasks.isEmpty()) {
            return false;
        }
        Task task = tasks.get(currentIndex);
        task.execute();

        if (task.isFinished()) {
            tasks.remove(currentIndex);
            if (tasks.size() == 0) {
                currentIndex = 0;
            } else {
                currentIndex %= tasks.size();
            }
        } else {
            currentIndex = (currentIndex + 1) % tasks.size();
        }
        return true;
    }

    public boolean isFull() {
        return tasks.size() >= capacity;
    }

    public boolean isEmpty() {
        return tasks.isEmpty();
    }
}
