package com.epam.rd.autotasks.triangle;

class Triangle {

    private final Point a;
    private final Point b;
    private final Point c;

    public Triangle(Point a, Point b, Point c) {
        // Проверяем, что треугольник не вырожденный
        if (areCollinear(a, b, c)) {
            throw new IllegalArgumentException("Triangle is degenerate (points are collinear)");
        }
        this.a = a;
        this.b = b;
        this.c = c;
    }

    // Метод для проверки коллинеарности точек
    private boolean areCollinear(Point p1, Point p2, Point p3) {
        // Площадь треугольника = 0 → точки коллинеарны
        double area = p1.getX() * (p2.getY() - p3.getY()) +
                p2.getX() * (p3.getY() - p1.getY()) +
                p3.getX() * (p1.getY() - p2.getY());
        return Math.abs(area) < 1e-9;
    }

    // Вычисление площади методом Шура (или формула Герона через координаты)
    public double area() {
        return Math.abs(
                a.getX() * (b.getY() - c.getY()) +
                        b.getX() * (c.getY() - a.getY()) +
                        c.getX() * (a.getY() - b.getY())
        ) / 2.0;
    }

    // Центроид треугольника (среднее координат вершин)
    public Point centroid() {
        double cx = (a.getX() + b.getX() + c.getX()) / 3.0;
        double cy = (a.getY() + b.getY() + c.getY()) / 3.0;
        return new Point(cx, cy);
    }
}
