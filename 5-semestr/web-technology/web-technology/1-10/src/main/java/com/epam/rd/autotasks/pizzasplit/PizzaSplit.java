package com.epam.rd.autotasks.pizzasplit;

import java.util.Scanner;

public class PizzaSplit {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = scanner.nextInt(); // количество людей
        int k = scanner.nextInt(); // кусочков в одной пицце

        int gcd = gcd(n, k);
        int lcm = (n * k) / gcd;

        int pizzas = lcm / k;
        System.out.println(pizzas);
    }

    private static int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}
