package com.epam.rd.autotasks.validations;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class EpamEmailValidation {

    public static boolean validateEpamEmail(String email) {
        if (email == null) {
            return false;
        }

        String regex = "^[a-z]+_[a-z]+\\d?@epam\\.com$";
        return email.matches(regex);
    }
}
