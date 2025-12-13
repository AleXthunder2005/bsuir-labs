package com.epam.rd.autotasks.words;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.StringJoiner;

public class StringUtil {

    public static int countEqualIgnoreCaseAndSpaces(String[] words, String sample) {
        if (words == null || words.length == 0 || sample == null) return 0;
        String sampleTrimmed = sample.strip();
        int count = 0;
        for (String word : words) {
            if (word.strip().equalsIgnoreCase(sampleTrimmed)) {
                count++;
            }
        }
        return count;
    }

    public static String[] splitWords(String text) {
        if (text == null || text.isBlank()) return null;
        String[] parts = text.split("[,.;:!?\\s]+");
        List<String> result = new ArrayList<>();
        for (String p : parts) {
            if (!p.isEmpty()) result.add(p);
        }
        return result.isEmpty() ? null : result.toArray(new String[0]);
    }

    public static String convertPath(String path, boolean toWin) {
        if (isPathIncorrect(path)) {
            return null;
        }
        String convertedPath;
        if (toWin) {
            convertedPath = path.replaceAll("~", "C:\\\\User");
            if (convertedPath.charAt(0) == '/') {
                convertedPath = convertedPath.replaceFirst("/", "C:\\\\");
            }
            convertedPath = convertedPath.replaceAll("/", "\\\\");
        } else {
            convertedPath = path.replaceAll("C:\\\\User", "~")
                    .replaceAll("C:\\\\", "/")
                    .replaceAll("\\\\", "/");
        }
        return convertedPath;
    }

    private static boolean isPathIncorrect(String path) {
        return path == null || path.isEmpty()
                || path.indexOf("~") != path.lastIndexOf("~")
                || (!path.startsWith("~") && path.contains("~"))
                || (path.contains("~") && path.contains("\\"))
                || (path.contains("C:") && !path.startsWith("C:"))
                || (path.contains("C:") && path.contains("/"))
                || path.indexOf("C:") != path.lastIndexOf("C:")
                || (path.contains("\\") && path.contains("/"));
    }





    public static String joinWords(String[] words) {
        if (words == null || words.length == 0) return null;
        StringJoiner joiner = new StringJoiner(", ", "[", "]");
        for (String word : words) {
            if (!word.isEmpty()) {
                joiner.add(word);
            }
        }
        String result = joiner.toString();
        return result.equals("[]") ? null : result;
    }

    public static void main(String[] args) {
        System.out.println("Test 1: countEqualIgnoreCaseAndSpaces");
        String[] words = new String[]{" WordS    \t", "words", "w0rds", "WOR  DS", };
        String sample = "words   ";
        int countResult = countEqualIgnoreCaseAndSpaces(words, sample);
        System.out.println("Result: " + countResult);
        int expectedCount = 2;
        System.out.println("Must be: " + expectedCount);

        System.out.println("Test 2: splitWords");
        String text = "   ,, first, second!!!! third";
        String[] splitResult = splitWords(text);
        System.out.println("Result : " + Arrays.toString(splitResult));
        String[] expectedSplit = new String[]{"first", "second", "third"};
        System.out.println("Must be: " + Arrays.toString(expectedSplit));

        System.out.println("Test 3: convertPath");
        String unixPath = "/some/unix/path";
        String convertResult = convertPath(unixPath, true);
        System.out.println("Result: " + convertResult);
        String expectedWinPath = "C:\\some\\unix\\path";
        System.out.println("Must be: " + expectedWinPath);

        System.out.println("Test 4: joinWords");
        String[] toJoin = new String[]{"go", "with", "the", "", "FLOW"};
        String joinResult = joinWords(toJoin);
        System.out.println("Result: " + joinResult);
        String expectedJoin = "[go, with, the, FLOW]";
        System.out.println("Must be: " + expectedJoin);
    }
}
