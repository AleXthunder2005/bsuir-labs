package com.epam.rd.autotasks;

import java.util.List;

public class HalvingCarouselRun extends CarouselRun {

    public HalvingCarouselRun(List<Integer> elements) {
        super(elements);
    }

    @Override
    public int next() {
        if (isFinished()) return -1;

        int startIndex = index;
        while (true) {
            if (data[index] > 0) {
                int value = data[index];
                data[index] = data[index] / 2;
                moveIndex();
                checkFinished();
                return value;
            }
            moveIndex();
            if (index == startIndex) {
                finished = true;
                return -1;
            }
        }
    }
}