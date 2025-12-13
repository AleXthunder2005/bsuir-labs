package com.epam.rd.autotasks.arithmeticexpressions;

import java.util.StringJoiner;

public class Expressions {

    public static Variable var(String name, int value) {
        return new Variable(name, value);
    }

    public static Expression val(int value) {
        return new Expression() {
            @Override
            public int evaluate() {
                return value;
            }

            @Override
            public String toExpressionString() {
                if (value < 0) {
                    return "(" + value + ")";
                }
                return String.valueOf(value);
            }
        };
    }

    public static Expression sum(Expression... members) {
        return new Expression() {
            @Override
            public int evaluate() {
                int result = 0;
                for (Expression e : members) {
                    result += e.evaluate();
                }
                return result;
            }

            @Override
            public String toExpressionString() {
                StringJoiner joiner = new StringJoiner(" + ");
                for (Expression e : members) {
                    joiner.add(e.toExpressionString());
                }
                return "(" + joiner.toString() + ")";
            }
        };
    }

    public static Expression product(Expression... members) {
        return new Expression() {
            @Override
            public int evaluate() {
                int result = 1;
                for (Expression e : members) {
                    result *= e.evaluate();
                }
                return result;
            }

            @Override
            public String toExpressionString() {
                StringJoiner joiner = new StringJoiner(" * ");
                for (Expression e : members) {
                    joiner.add(e.toExpressionString());
                }
                return "(" + joiner.toString() + ")";
            }
        };
    }

    public static Expression difference(Expression minuend, Expression subtrahend) {
        return new Expression() {
            @Override
            public int evaluate() {
                return minuend.evaluate() - subtrahend.evaluate();
            }

            @Override
            public String toExpressionString() {
                return "(" + minuend.toExpressionString() + " - " + subtrahend.toExpressionString() + ")";
            }
        };
    }

    public static Expression fraction(Expression dividend, Expression divisor) {
        return new Expression() {
            @Override
            public int evaluate() {
                return dividend.evaluate() / divisor.evaluate();
            }

            @Override
            public String toExpressionString() {
                return "(" + dividend.toExpressionString() + " / " + divisor.toExpressionString() + ")";
            }
        };
    }
}
