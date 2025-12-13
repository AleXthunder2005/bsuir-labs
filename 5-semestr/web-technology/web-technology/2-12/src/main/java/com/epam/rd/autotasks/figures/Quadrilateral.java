package com.epam.rd.autotasks.figures;

public class Quadrilateral extends Figure {
    private final Point a, b, c, d;
    private static final double EPS = 1e-9;

    public Quadrilateral(Point a, Point b, Point c, Point d) {
        if (a == null || b == null || c == null || d == null)
            throw new IllegalArgumentException("Points cannot be null");
        this.a = a; this.b = b; this.c = c; this.d = d;

        if (!isConvex() || area() < EPS)
            throw new IllegalArgumentException("Degenerate or non-convex quadrilateral");

        if (triangleArea(a,b,c) < EPS || triangleArea(a,c,d) < EPS ||
                triangleArea(a,b,d) < EPS || triangleArea(b,c,d) < EPS)
            throw new IllegalArgumentException("Degenerate quadrilateral");
    }

    private double triangleArea(Point p1, Point p2, Point p3) {
        return Math.abs((p1.getX()*(p2.getY()-p3.getY()) +
                p2.getX()*(p3.getY()-p1.getY()) +
                p3.getX()*(p1.getY()-p2.getY())) / 2.0);
    }


    @Override
    public double area() {
        // Делим на два треугольника: ABC и ACD
        double area1 = Math.abs((a.getX()*(b.getY()-c.getY()) + b.getX()*(c.getY()-a.getY()) + c.getX()*(a.getY()-b.getY()))/2.0);
        double area2 = Math.abs((a.getX()*(c.getY()-d.getY()) + c.getX()*(d.getY()-a.getY()) + d.getX()*(a.getY()-c.getY()))/2.0);
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

    public Point centroid() {
        // Центроид как средневзвешенный по площади
        Point[] pts = {a,b,c,d};
        double totalArea = 0;
        double cx = 0, cy = 0;

        int[][] triangles = {{0,1,2},{0,2,3}}; // два треугольника ABC и ACD
        for (int[] tri : triangles) {
            Triangle t = new Triangle(pts[tri[0]], pts[tri[1]], pts[tri[2]]);
            double ar = t.area();
            Point cT = t.centroid();
            cx += cT.getX()*ar;
            cy += cT.getY()*ar;
            totalArea += ar;
        }
        return new Point(cx/totalArea, cy/totalArea);
    }

    public boolean isTheSame(Figure figure) {
        if (!(figure instanceof Quadrilateral)) return false;
        Quadrilateral q = (Quadrilateral) figure;
        return containsAllPoints(new Point[]{a,b,c,d}, new Point[]{q.a,q.b,q.c,q.d});
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

    private boolean isConvex() {
        Point[] pts = {a,b,c,d};
        int sign = 0;
        for (int i=0;i<4;i++) {
            double dx1 = pts[(i+1)%4].getX()-pts[i].getX();
            double dy1 = pts[(i+1)%4].getY()-pts[i].getY();
            double dx2 = pts[(i+2)%4].getX()-pts[(i+1)%4].getX();
            double dy2 = pts[(i+2)%4].getY()-pts[(i+1)%4].getY();
            double z = dx1*dy2 - dy1*dx2;
            if (i==0) sign = (z>0?1:-1);
            else if ((z>0?1:-1)!=sign) return false;
        }
        return true;
    }
}
