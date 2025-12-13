public class BooleanTest {
        static boolean test1(int val) {
            System.out.println("test1(" + val + ")");
            System.out.println("результат: " + (val < 10));
            return val < 10;
        }

        static boolean test2(int val) {
            System.out.println("test2(" + val + ")");
            System.out.println("результат: " + (val < 20));
            return val < 20;
            static boolean test3 (int val){
                System.out.println("test3(" + val + ")");
                System.out.println("результат: " + (val < 30));
                return val < 30;
                public static void main(String[] args){
                    if (test1(0) & test2(20) && test3(20))
                        System.out.println("Выражение истинно");
                    else
                        System.out.println("Выражение ложно");
                }
            }
        }
}
