package com.epam.rd.autotasks.figures;

public class Quadrilateral extends Figure {
    private Point a, b, c, d;

    public Quadrilateral(Point a, Point b, Point c, Point d) {
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
    }

    @Override
    public double area() {
        // Разделим на два треугольника: ABC и ACD
        double area1 = Math.abs((a.getX()*(b.getY()-c.getY()) + b.getX()*(c.getY()-a.getY()) + c.getX()*(a.getY()-b.getY())) / 2.0);
        double area2 = Math.abs((a.getX()*(c.getY()-d.getY()) + c.getX()*(d.getY()-a.getY()) + d.getX()*(a.getY()-c.getY())) / 2.0);
        return area1 + area2;
    }

    @Override
    public String pointsToString() {
        return "(" + a.getX() + "," + a.getY() + ")" +
                "(" + b.getX() + "," + b.getY() + ")" +
                "(" + c.getX() + "," + c.getY() + ")" +
                "(" + d.getX() + "," + d.getY() + ")";
    }

    @Override
    public Point leftmostPoint() {
        Point left = a;
        if (b.getX() < left.getX()) left = b;
        if (c.getX() < left.getX()) left = c;
        if (d.getX() < left.getX()) left = d;
        return left;
    }
}
