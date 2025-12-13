package com.epam.rd.autotasks.figures;

public class Circle extends Figure {
    private final Point center;
    private final double radius;
    private static final double EPS = 1e-9;

    public Circle(Point center, double radius) {
        if (center == null) throw new IllegalArgumentException("Center cannot be null");
        if (radius <= EPS) throw new IllegalArgumentException("Radius must be positive");
        this.center = center;
        this.radius = radius;
    }

    @Override
    public double area() {
        return Math.PI*radius*radius;
    }

    @Override
    public String pointsToString() {
        return "(" + center.getX() + "," + center.getY() + ")";
    }

    @Override
    public String toString() {
        return this.getClass().getSimpleName()+"["+pointsToString()+radius+"]";
    }

    @Override
    public Point leftmostPoint() {
        return new Point(center.getX()-radius, center.getY());
    }

    public Point centroid() {
        return center;
    }

    public boolean isTheSame(Figure figure) {
        if (!(figure instanceof Circle)) return false;
        Circle c = (Circle) figure;
        return Math.abs(center.getX()-c.center.getX())<EPS &&
                Math.abs(center.getY()-c.center.getY())<EPS &&
                Math.abs(radius-c.radius)<EPS;
    }
}
