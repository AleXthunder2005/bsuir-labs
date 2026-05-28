using System.Diagnostics;
using System.Reflection;
using TestLibrary.Attributes;
using TestLibrary.Constants;
using TestLibrary.Exceptions;
using TestRunner;

namespace TestRunnerApp
{
    class Program
    {
        static async Task<int> Main(string[] args)
        {
            Console.WriteLine("Example of dll path: C:\\6-semestr\\modern-programming-platforms\\lab1\\lab2 (treading-encryption-with-lfsr)\\ProjectFunctionalityTests\\bin\\Debug\\net9.0\\ProjectFunctionalityTests.dll");
            // loading dll with tests
            Assembly? assemblyOutParameter;
            bool isDllLoadingSuccessful = false;
            do
            {
                // input path to dll with tests
                string? assemblyPath = getDllPath();

                //try load this dll, if failed - ask again
                isDllLoadingSuccessful = tryLoadAssembly(assemblyPath, out assemblyOutParameter);
            } while (!isDllLoadingSuccessful);

            Assembly asm = assemblyOutParameter!;


            // finding test classes
            Type[]? testClassTypes = getTestClasses(asm);
            if ((testClassTypes == null) || (!testClassTypes.Any()))
            {
                Console.WriteLine("No test classes found.");
                return 0;
            }

            // collect all test cases
            List<TestCase> allTestCases = getAllTestCases(testClassTypes);

            // grouping by TestClass
            var groupedByTestClassCases = allTestCases.GroupBy(t => t.TestClassType);

            var summary = new List<TestCaseResult>(); // summary of results for all test cases

            //processing of each test class
            foreach (var group in groupedByTestClassCases)
            {
                var testClassType = group.Key;
                Console.WriteLine($"\nTestClass: {testClassType.FullName}");
                Console.WriteLine($"----------------------------------------------------------------------------------");

                var orderedTestClassCases = group.OrderBy(t => t.Priority)
                    .ThenBy(t => t.Method.Name)
                    .ThenBy(t => string.Join(", ", t.Arguments))
                    .ToList();


                //create test class instance
                object? testClassInstance = createTestClassInstance(testClassType);
                if (testClassInstance == null)
                {
                    // cannot create instance of TestClass - all tests in this class will be marked as error
                    foreach (var testCase in orderedTestClassCases)
                        summary.Add(new TestCaseResult(testCase, TestStatus.Error, $"Cannot create instance of ${testClassType.Name}"));
                    continue;
                }


                // process setup method (if exists)
                bool isSetupMethodProcessingSuccessful = await processSetupMethod(testClassType, testClassInstance);
                if (!isSetupMethodProcessingSuccessful)
                {
                    // if setup method failed - all tests in this class will be marked as error
                    foreach (var testCase in orderedTestClassCases)
                        summary.Add(new TestCaseResult(testCase, TestStatus.Error, $"TestSetup failed"));
                    continue;
                }

                // process all test cases in this class
                foreach (var testCase in orderedTestClassCases)
                {
                    if (testCase.Ignore)
                    {
                        summary.Add(new TestCaseResult(testCase, TestStatus.Ignored, testCase.IgnoreReason));
                        Console.ForegroundColor = ConsoleColor.Yellow;
                        Console.WriteLine($"[IGNORED] {testCase.TestName} - {testCase.IgnoreReason ?? "no reason"} (0 ms)");
                        Console.WriteLine($"About test case: {testCase.TestDescription ?? ""}");
                        Console.WriteLine("----------------------------------------------------------------------------------");
                        Console.ResetColor();
                        continue;
                    }

                    var result = await RunTestCase(testClassInstance, testCase);
                    summary.Add(result);
                }

                await processClearSetupMethod(testClassType, testClassInstance);
            }

            // output summary
            Console.WriteLine();
            int passed = summary.Count(s => s.Status == TestStatus.Passed);
            int failed = summary.Count(s => s.Status == TestStatus.Failed);
            int skipped = summary.Count(s => s.Status == TestStatus.Ignored);
            int error = summary.Count(s => s.Status == TestStatus.Error);

            var totalDuration = summary.Aggregate(TimeSpan.Zero, (sum, r) => sum + r.Duration);
            
            Console.WriteLine($"Total: {summary.Count}, Passed: {passed}, Failed: {failed}, Skipped: {skipped}, Error: {error}");
            Console.WriteLine($"Total duration: {totalDuration}");
            
            return 0;
        }

        private static string getDllPath()
        {
            string? assemblyPath;
            bool isValidInput = false;
            do
            {
                Console.WriteLine("Enter full path to the test assembly (.dll):");
                Console.Write("> ");
                assemblyPath = Console.ReadLine()?.Trim().Trim('"');

                if (string.IsNullOrWhiteSpace(assemblyPath) || !File.Exists(assemblyPath))
                {
                    Console.WriteLine("ERROR: invalid path");
                }
                else
                {
                    isValidInput = true;
                }
            } while (!isValidInput);

            return assemblyPath!;
        }

        private static bool tryLoadAssembly(string assemblyPath, out Assembly? assembly)
        {
            try
            {
                assembly = Assembly.LoadFrom(assemblyPath);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"ERROR: failed to load assembly: {ex.Message}");
                assembly = null;
                return false;
            }

            Console.WriteLine($"Loaded assembly: {assemblyPath}");
            return true;
        }

        private static Type[]? getTestClasses(Assembly asm)
        {
            Type[]? testClassTypes = asm.GetTypes()
                .Where(t => t.GetCustomAttribute<TestClassAttribute>() != null)
                .ToArray();

            return testClassTypes;
        }

        private static List<TestCase> getAllTestCases(Type[] testClassTypes)
        {
            var allTestCases = new List<TestCase>();

            foreach (var type in testClassTypes)
            {
                // collect all methods with [Test] attribute
                var methods = type.GetMethods(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)
                                  .Where(m => m.GetCustomAttribute<TestAttribute>() != null);

                foreach (var m in methods)
                {
                    //collect methods attributes
                    var priorityAttr = m.GetCustomAttribute<TestPriorityAttribute>();
                    var ignoreAttr = m.GetCustomAttribute<TestIgnoreAttribute>();
                    var descriptionAttr = m.GetCustomAttribute<TestDescriptionAttribute>();
                    var paramAttrs = m.GetCustomAttributes<TestWithParamsAttribute>().ToArray();

                    if (paramAttrs.Length == 0)
                    {
                        // simple test case without parameters
                        allTestCases.Add(new TestCase
                        {
                            TestClassType = type,
                            Method = m,
                            Arguments = Array.Empty<object>(),
                            Priority = priorityAttr?.Priority ?? TestPriority.P_MEDIUM,
                            Ignore = ignoreAttr != null,
                            IgnoreReason = ignoreAttr?.IgnoreReason,
                            TestDescription = descriptionAttr?.Description
                        });
                    }
                    else
                    {
                        // test cases with more parametres
                        foreach (var paramAttr in paramAttrs)
                        {
                            allTestCases.Add(new TestCase
                            {
                                TestClassType = type,
                                Method = m,
                                Arguments = paramAttr.Parameters,
                                Priority = priorityAttr?.Priority ?? TestPriority.P_MEDIUM,
                                Ignore = ignoreAttr != null,
                                IgnoreReason = ignoreAttr?.IgnoreReason,
                                TestDescription = descriptionAttr?.Description
                            });
                        }
                    }
                }
            }

            return allTestCases;
        }

        private static object? createTestClassInstance(Type testClassType)
        {
            object? testClassInstance = null;
            try
            {
                testClassInstance = Activator.CreateInstance(testClassType)
                    ?? throw new Exception("Activator returned null");
            }
            catch (Exception ex)
            {
                // cannot create instance of TestClass - all tests in this class will be marked as error
                Console.WriteLine($"ERROR: cannot create instance: {ex.Message}");
            }

            return testClassInstance;
        }

        private static async Task<bool> processSetupMethod(Type testClassType, object testClassInstance)
        {
            var setupMethod = testClassType.GetMethods(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)
                .FirstOrDefault(m => m.GetCustomAttribute<TestSetupAttribute>() != null);

            if (setupMethod != null)
            {
                try
                {
                    await InvokeSyncOrAsync(setupMethod, testClassInstance);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"ERROR: TestSetup failed: {ex.GetBaseException().Message}");
                    return false;
                }
            }
            return true;
        }

        private static async Task<bool> processClearSetupMethod(Type testClassType, object testClassInstance)
        {
            var setupClearMethod = testClassType.GetMethods(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)
                .FirstOrDefault(m => m.GetCustomAttribute<TestClearSetupAttribute>() != null);

            if (setupClearMethod != null)
            {
                try
                {
                    await InvokeSyncOrAsync(setupClearMethod, testClassInstance);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"ERROR: Test clear setup failed: {ex.GetBaseException().Message}");
                    return false;
                }
            }
            return true;
        }

        private static async Task<TestCaseResult> RunTestCase(object testClassInstance, TestCase testCase)
        {
            var stopwatch = Stopwatch.StartNew();

            try
            {
                await InvokeSyncOrAsync(testCase.Method, testClassInstance, testCase.Arguments);
                stopwatch.Stop();

                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine($"[PASSED] {testCase.TestName} ({stopwatch.Elapsed})");
                Console.WriteLine($"About test case: {testCase.TestDescription ?? ""}");
                Console.WriteLine("----------------------------------------------------------------------------------");
                Console.ResetColor();

                return new TestCaseResult(testCase, TestStatus.Passed, null, stopwatch.Elapsed);
            }
            catch (TargetInvocationException targetInvEx)
            {
                stopwatch.Stop();
                var ex = targetInvEx.InnerException ?? targetInvEx;
                return HandleTestException(testCase, ex, stopwatch);
            }
            catch (Exception ex)
            {
                stopwatch.Stop();
                return HandleTestException(testCase, ex, stopwatch);
            }
        }

        private static TestCaseResult HandleTestException(TestCase testCase, Exception ex, Stopwatch stopwatch)
        {
            if (ex is AssertException || ex.GetType().IsSubclassOf(typeof(AssertException)))
            {
                // failed test exception
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine($"[FAILED] {testCase.TestName} - {ex.Message} ({stopwatch.Elapsed})");
                Console.WriteLine($"About test case: {testCase.TestDescription ?? ""}");
                Console.WriteLine("----------------------------------------------------------------------------------");
                Console.ResetColor();

                return new TestCaseResult(testCase, TestStatus.Failed, ex.Message, stopwatch.Elapsed);
            }
            else
            {
                // unexpected exception
                Console.ForegroundColor = ConsoleColor.DarkRed;
                Console.WriteLine($"[ERROR] {testCase.TestName} - {ex.GetType().Name}: {ex.Message}");
                Console.WriteLine($"About test case: {testCase.TestDescription ?? ""}");
                Console.WriteLine("----------------------------------------------------------------------------------");
                Console.ResetColor();

                return new TestCaseResult(testCase, TestStatus.Error, $"{ex.GetType().Name}: {ex.Message}", stopwatch.Elapsed);
            }
        }

        private static async Task InvokeSyncOrAsync(MethodInfo method, object instance, object[]? args = null)
        {
            // receive arguments
            args ??= Array.Empty<object>();

            // invoke method
            var result = method.Invoke(instance, args);

            if (result is Task task)
            {
                await task;
                return;
            }

            if (result is ValueTask valueTask)
            {
                await valueTask;
                return;
            }

            // if sync method and not void
            if (result != null)
            {
                var type = result.GetType();

                if (type.IsGenericType && type.GetGenericTypeDefinition() == typeof(ValueTask<>))
                {
                    await ((dynamic)result);
                }
            }
        }
    }
}
