package com.epam.rd.autotasks;

public class DecrementingCarouselWithLimitedRun extends DecrementingCarousel {

    private final int limit;

    public DecrementingCarouselWithLimitedRun(int capacity, int limit) {
        super(capacity);
        this.limit = limit;
    }

    @Override
    public LimitedCarouselRun run() {
        if (running) return null;
        running = true;
        return new LimitedCarouselRun(elements, limit);
    }
}
