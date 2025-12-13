package com.epam.rd.autotasks;

import java.util.List;

public class GraduallyDecreasingCarouselRun extends CarouselRun {

    private final int[] decrements;

    public GraduallyDecreasingCarouselRun(List<Integer> elements) {
        super(elements);
        decrements = new int[data.length];
        for (int i = 0; i < decrements.length; i++) {
            decrements[i] = 1; // первый декремент всегда на 1
        }
    }

    @Override
    public int next() {
        if (isFinished()) return -1;

        int startIndex = index;
        while (true) {
            if (data[index] > 0) {
                int value = data[index];
                data[index] = Math.max(0, data[index] - decrements[index]);
                decrements[index]++;
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
