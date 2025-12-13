package com.epam.rd.autotasks.sequence;

import java.util.Scanner;

public class FindMaxInSeq {
    public static void main(String[] args) {
        System.out.println(max());
    }

    public static int max() {
        Scanner scanner = new Scanner(System.in);
        int current = scanner.nextInt();
        int max = current;

        while (current != 0) {
            if (current > max) {
                max = current;
            }
            current = scanner.nextInt();
        }

        return max;
    }
}
