package com.epam.rd.autotasks.segments;

import static java.lang.Math.sqrt;

class Segment {

    private final Point start;
    private final Point end;

    public Segment(Point start, Point end) {
        if (start.getX() == end.getX() && start.getY() == end.getY()) {
            throw new IllegalArgumentException("Segment cannot be degenerate (start == end)");
        }
        this.start = start;
        this.end = end;
    }

    // Длина отрезка
    double length() {
        double dx = end.getX() - start.getX();
        double dy = end.getY() - start.getY();
        return sqrt(dx * dx + dy * dy);
    }

    // Средняя точка
    Point middle() {
        double mx = (start.getX() + end.getX()) / 2;
        double my = (start.getY() + end.getY()) / 2;
        return new Point(mx, my);
    }

    // Пересечение двух отрезков
    Point intersection(Segment another) {
        double x1 = this.start.getX();
        double y1 = this.start.getY();
        double x2 = this.end.getX();
        double y2 = this.end.getY();

        double x3 = another.start.getX();
        double y3 = another.start.getY();
        double x4 = another.end.getX();
        double y4 = another.end.getY();

        double d = (x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4);

        if (d == 0) {
            // Линии параллельны или коллинеарны
            return null;
        }

        double numX = (x1*y2 - y1*x2)*(x3 - x4) - (x1 - x2)*(x3*y4 - y3*x4);
        double numY = (x1*y2 - y1*x2)*(y3 - y4) - (y1 - y2)*(x3*y4 - y3*x4);

        double ix = numX / d;
        double iy = numY / d;

        // Проверка, что точка лежит на обоих отрезках
        if (isBetween(x1, x2, ix) && isBetween(y1, y2, iy) &&
                isBetween(x3, x4, ix) && isBetween(y3, y4, iy)) {
            return new Point(ix, iy);
        } else {
            return null;
        }
    }

    // Вспомогательный метод: проверка, что c лежит между a и b
    private boolean isBetween(double a, double b, double c) {
        return c >= Math.min(a, b) - 1e-9 && c <= Math.max(a, b) + 1e-9;
    }
}
