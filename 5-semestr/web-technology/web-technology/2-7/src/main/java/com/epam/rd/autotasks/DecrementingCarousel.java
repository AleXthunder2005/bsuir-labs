package com.epam.rd.autotasks;

import java.util.ArrayList;
import java.util.List;

public class DecrementingCarousel {

    protected final int capacity;
    protected final List<Integer> elements;
    protected boolean running; // true, если run() уже вызван

    public DecrementingCarousel(int capacity) {
        this.capacity = capacity;
        this.elements = new ArrayList<>();
        this.running = false;
    }

    public boolean addElement(int element) {
        if (element <= 0) return false;         // отрицательные или ноль запрещены
        if (elements.size() >= capacity) return false; // контейнер заполнен
        if (running) return false;              // нельзя добавлять после run()
        elements.add(element);
        return true;
    }

    public CarouselRun run() {
        if (running) return null; // можно создать только один CarouselRun
        running = true;
        return new CarouselRun(elements);
    }
}
