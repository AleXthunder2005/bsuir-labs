package com.epam.rd.autotasks.figures;

import java.util.Arrays;

public class Triangle extends Figure {
    private final Point a, b, c;
    private static final double EPS = 1e-9;

    public Triangle(Point a, Point b, Point c) {
        if (a == null || b == null || c == null) {
            throw new IllegalArgumentException("Points cannot be null");
        }
        this.a = a;
        this.b = b;
        this.c = c;
        if (area() < EPS) {
            throw new IllegalArgumentException("Degenerate triangle");
        }
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

    public Point centroid() {
        double x = (a.getX() + b.getX() + c.getX()) / 3.0;
        double y = (a.getY() + b.getY() + c.getY()) / 3.0;
        return new Point(x, y);
    }

    public boolean isTheSame(Figure figure) {
        if (!(figure instanceof Triangle)) return false;
        Triangle t = (Triangle) figure;
        return containsAllPoints(new Point[]{a,b,c}, new Point[]{t.a, t.b, t.c});
    }

    private boolean containsAllPoints(Point[] p1, Point[] p2) {
        for (Point pt1 : p1) {
            boolean found = false;
            for (Point pt2 : p2) {
                if (Math.abs(pt1.getX()-pt2.getX())<EPS && Math.abs(pt1.getY()-pt2.getY())<EPS) {
                    found = true;
                    break;
                }
            }
            if (!found) return false;
        }
        return true;
    }
}
