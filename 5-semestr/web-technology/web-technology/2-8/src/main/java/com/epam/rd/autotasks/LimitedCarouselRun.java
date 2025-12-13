package com.epam.rd.autotasks;

import java.util.List;

public class LimitedCarouselRun extends CarouselRun {

    private final int limit;
    private int callsMade;     // счетчик вызовов

    public LimitedCarouselRun(List<Integer> elements, int limit) {
        super(elements);
        this.limit = limit;
        this.callsMade = 0;
    }

    @Override
    public int next() {
        if (isFinished()) return -1;

        int value = super.next();
        if (value != -1) {
            callsMade++;
            if (callsMade >= limit) {
                finished = true;   // конец
            }
        }
        return value;
    }
}
