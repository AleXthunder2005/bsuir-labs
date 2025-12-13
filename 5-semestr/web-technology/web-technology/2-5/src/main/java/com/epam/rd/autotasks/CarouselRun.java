package com.epam.rd.autotasks;

import java.util.List;

public class CarouselRun {

    private final int[] data;   // массив для итерации
    private int index;          // текущий индекс
    private boolean finished;   // флаг окончания

    public CarouselRun(List<Integer> elements) {
        data = new int[elements.size()];
        for (int i = 0; i < elements.size(); i++) {
            data[i] = elements.get(i);
        }
        index = 0;
        finished = data.length == 0;
    }

    public int next() {
        if (finished) return -1;

        int startIndex = index;
        while (true) {
            if (data[index] > 0) {
                int value = data[index];
                data[index]--;
                moveIndex();
                checkFinished();
                return value;
            }
            moveIndex();
            if (index == startIndex) { // прошли весь массив, ничего не осталось
                finished = true;
                return -1;
            }
        }
    }

    private void moveIndex() {
        index++;
        if (index >= data.length) index = 0;
    }

    private void checkFinished() {
        for (int v : data) {
            if (v > 0) return;
        }
        finished = true;
    }

    public boolean isFinished() {
        return finished;
    }
}
