import {lex} from './lexer.mjs';
import {Parser} from './parser.mjs';
import {analyze} from "./analyzer.mjs";

const code = `using System;
class Program {
    static void Main() {
        if (y < 4) {
            switch (y) {
                case 1:
                    Console.WriteLine("one");
                    break;
                case 2:
                    if (x == 0) {
                        Console.WriteLine("x is zero");
                    } else if (y < 0) {
                        Console.WriteLine("y is negative");
                    }
                    break;
                case 3:
                    Console.WriteLine("3");
                    break;
                default:
                    Console.WriteLine("default");
                    break;
            }
        }
    }
}`;

const tokens = lex(code);
const result = new Parser(tokens).parseProgram();
const metrics = analyze(result);
console.log(metrics);