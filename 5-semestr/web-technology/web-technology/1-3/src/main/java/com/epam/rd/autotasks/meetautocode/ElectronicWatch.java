package com.epam.rd.autotasks.meetautocode;

import java.util.Scanner;

public class ElectronicWatch {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int input = scanner.nextInt();

        int secondsInDay = 24 * 60 * 60;

        int totalSeconds = input % secondsInDay;

        int hours = totalSeconds / 3600;
        int minutes = (totalSeconds % 3600) / 60;
        int seconds = totalSeconds % 60;

        System.out.printf("%d:%02d:%02d", hours, minutes, seconds);
    }
}
