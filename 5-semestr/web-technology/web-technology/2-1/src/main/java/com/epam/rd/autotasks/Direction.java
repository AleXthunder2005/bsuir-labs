package com.epam.rd.autotasks;

public enum Direction {
    N(0), NE(45), E(90), SE(135), S(180), SW(225), W(270), NW(315);

    private final int degrees;

    Direction(final int degrees) {
        this.degrees = degrees;
    }

    // Возвращает Direction с точным совпадением градусов или null
    public static Direction ofDegrees(int degrees) {
        degrees = ((degrees % 360) + 360) % 360; // нормализация в [0, 360)
        for (Direction dir : values()) {
            if (dir.degrees == degrees) return dir;
        }
        return null;
    }

    // Возвращает Direction, ближайший к указанным градусам
    public static Direction closestToDegrees(int degrees) {
        degrees = ((degrees % 360) + 360) % 360;
        Direction closest = N;
        int minDiff = 360;
        for (Direction dir : values()) {
            int diff = Math.abs(dir.degrees - degrees);
            diff = Math.min(diff, 360 - diff);
            if (diff < minDiff) {
                minDiff = diff;
                closest = dir;
            }
        }
        return closest;
    }

    // Возвращает противоположное направление
    public Direction opposite() {
        int oppositeDegrees = (this.degrees + 180) % 360;
        return ofDegrees(oppositeDegrees);
    }

    // Разница в градусах между текущим и другим направлением
    public int differenceDegreesTo(Direction direction) {
        int diff = Math.abs(this.degrees - direction.degrees);
        return Math.min(diff, 360 - diff);
    }

    public static void main(String[] args) {

    }
}
