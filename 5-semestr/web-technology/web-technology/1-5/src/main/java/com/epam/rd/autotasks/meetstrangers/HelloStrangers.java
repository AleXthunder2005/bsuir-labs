package com.epam.rd.autotasks.meetstrangers;

import java.util.Scanner;

public class HelloStrangers {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = scanner.nextInt();
        scanner.nextLine();

        if (n < 0) {
            System.out.println("Seriously? Why so negative?");
        } else if (n == 0) {
            System.out.println("Oh, it looks like there is no one here");
        } else {
            for (int i = 0; i < n; i++) {
                String name = scanner.nextLine();
                System.out.println("Hello, " + name);
            }
        }
    }
}
