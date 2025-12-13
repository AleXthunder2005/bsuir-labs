package com.epam.rd.autotasks;

class CycleSwap {
    static void cycleSwap(int[] array) {
        if (array == null || array.length == 0) {
            return;
        }
        int last = array[array.length - 1];
        for (int i = array.length - 1; i > 0; i--) {
            array[i] = array[i - 1];
        }
        array[0] = last;
    }

    static void cycleSwap(int[] array, int shift) {
        if (array == null || array.length == 0) {
            return;
        }
        int n = array.length;
        shift = shift % n;
        if (shift == 0) return;

        int[] temp = new int[n];
        for (int i = 0; i < n; i++) {
            temp[(i + shift) % n] = array[i];
        }
        System.arraycopy(temp, 0, array, 0, n);
    }
}
