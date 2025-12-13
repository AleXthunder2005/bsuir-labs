package com.epam.rd.autotasks;

public class HalvingCarousel extends DecrementingCarousel {

    public HalvingCarousel(final int capacity) {
        super(capacity);
    }

    @Override
    public HalvingCarouselRun run() {
        if (running) return null;
        running = true;
        return new HalvingCarouselRun(elements);
    }
}




