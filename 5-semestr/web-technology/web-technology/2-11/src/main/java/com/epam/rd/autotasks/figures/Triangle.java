package com.epam.rd.autotasks.figures;

public class Triangle extends Figure {
    private Point a, b, c;

    public Triangle(Point a, Point b, Point c) {
        this.a = a;
        this.b = b;
        this.c = c;
    }

    @Override
    public double area() {
        return Math.abs((a.getX()*(b.getY()-c.getY()) + b.getX()*(c.getY()-a.getY()) + c.getX()*(a.getY()-b.getY())) / 2.0);
    }

    @Override
    public String pointsToString() {
        return "(" + a.getX() + "," + a.getY() + ")" +
                "(" + b.getX() + "," + b.getY() + ")" +
                "(" + c.getX() + "," + c.getY() + ")";
    }

    @Override
    public Point leftmostPoint() {
        Point left = a;
        if (b.getX() < left.getX()) left = b;
        if (c.getX() < left.getX()) left = c;
        return left;
    }
}
