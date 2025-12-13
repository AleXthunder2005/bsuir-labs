package com.epam.rd.autotasks;

public class Battleship8x8 {
    private final long ships;
    private long shots = 0L;

    public Battleship8x8(final long ships) {
        this.ships = ships;
    }

    public boolean shoot(String shot) {
        // Преобразуем координаты выстрела в номер бита
        char colChar = shot.charAt(0);
        int row = Integer.parseInt(shot.substring(1)) - 1; // строки от 0 до 7
        int col = colChar - 'A'; // столбцы от 0 до 7

        int bitIndex = row * 8 + col;
        long bitMask = 1L << (63 - bitIndex);

        shots |= bitMask;

        // Проверяем, попали ли в корабль
        return (ships & bitMask) != 0;
    }

    public String state() {
        StringBuilder sb = new StringBuilder();

        for (int row = 0; row < 8; row++) {
            for (int col = 0; col < 8; col++) {
                int bitIndex = row * 8 + col;
                long bitMask = 1L << (63 - bitIndex);

                boolean hasShip = (ships & bitMask) != 0;
                boolean hasShot = (shots & bitMask) != 0;

                if (hasShip && hasShot) {
                    sb.append('☒');
                } else if (hasShip) {
                    sb.append('☐');
                } else if (hasShot) {
                    sb.append('×');
                } else {
                    sb.append('.');
                }
            }
            if (row < 7) {
                sb.append('\n');
            }
        }

        return sb.toString();
    }
}
