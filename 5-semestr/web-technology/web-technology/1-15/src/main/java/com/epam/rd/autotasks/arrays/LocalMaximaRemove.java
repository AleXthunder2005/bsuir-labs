package com.epam.rd.autotasks.arrays;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class LocalMaximaRemove {

    public static void main(String[] args) {
        int[] array = new int[]{18, 1, 3, 6, 7, -5};

        System.out.println(Arrays.toString(removeLocalMaxima(array)));
    }

    public static int[] removeLocalMaxima(int[] array) {
        List<Integer> result = new ArrayList<>();

        for (int i = 0; i < array.length; i++) {
            if (i == 0) {
                // первый элемент
                if (array[i] <= array[i + 1]) {
                    result.add(array[i]);
                }
            } else if (i == array.length - 1) {
                // последний элемент
                if (array[i] <= array[i - 1]) {
                    result.add(array[i]);
                }
            } else {
                // элементы внутри массива
                if (!(array[i] > array[i - 1] && array[i] > array[i + 1])) {
                    result.add(array[i]);
                }
            }
        }

        // преобразуем список обратно в массив
        int[] resArray = new int[result.size()];
        for (int i = 0; i < result.size(); i++) {
            resArray[i] = result.get(i);
        }

        return resArray;
    }
}
