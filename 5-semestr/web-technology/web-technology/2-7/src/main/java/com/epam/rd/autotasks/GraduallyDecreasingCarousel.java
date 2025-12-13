package com.epam.rd.autotasks;

public class GraduallyDecreasingCarousel extends DecrementingCarousel {

    public GraduallyDecreasingCarousel(final int capacity) {
        super(capacity);
    }

    @Override
    public GraduallyDecreasingCarouselRun run() {
        if (running) return null;
        running = true;
        return new GraduallyDecreasingCarouselRun(elements);
    }
}
