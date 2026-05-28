using System.Collections.Concurrent;
using System.Diagnostics;
using System.Reflection;
using TestLibrary.Attributes;
using TestLibrary.Constants;
using TestLibrary.Exceptions;
using TestRunner;

namespace ParallelTestRunnerApp
{
    class Program
    {
        private static readonly object _consoleLock = new();
        private static readonly Stopwatch _globalClock = Stopwatch.StartNew();

        static async Task<int> Main(string[] args)
        {
            int maxParallel = 4;

            Console.WriteLine($"MaxDegreeOfParallelism = {maxParallel}");
            Console.WriteLine("Example of dll path: C:\\6-semestr\\modern-programming-platforms\\lab1\\lab2 (treading-encryption-with-lfsr)\\ProjectFunctionalityTests\\bin\\Debug\\net9.0\\ProjectFunctionalityTests.dll");
            Console.WriteLine("--------------------------------------------------");

            Assembly? assemblyOutParameter;
            bool isDllLoadingSuccessful = false;

            do
            {
                string? assemblyPath = getDllPath();
                isDllLoadingSuccessful = tryLoadAssembly(assemblyPath, out assemblyOutParameter);
            } while (!isDllLoadingSuccessful);

            Assembly asm = assemblyOutParameter!;

            var testClassTypes = getTestClasses(asm);
            var allTestCases = getAllTestCases(testClassTypes!);

            var grouped = allTestCases.GroupBy(t => t.TestClassType);

            var semaphore = new SemaphoreSlim(maxParallel);
            var summary = new ConcurrentBag<TestCaseResult>();

            var globalStopwatch = Stopwatch.StartNew();

            foreach (var group in grouped)
            {
                var testClassType = group.Key;

                Console.WriteLine($"\nTestClass: {testClassType.FullName}");
                Console.WriteLine("--------------------------------------------------");

                object? instance;

                try
                {
                    instance = Activator.CreateInstance(testClassType);

                    if (instance == null)
                        throw new Exception("Cannot create instance");
                }
                catch (Exception ex)
                {
                    foreach (var tc in group)
                    {
                        summary.Add(new TestCaseResult(tc, TestStatus.Error, ex.Message));
                    }
                    continue;
                }

                // test setup method
                try
                {
                    await processSetup(testClassType, instance);
                }
                catch (Exception ex)
                {
                    foreach (var tc in group)
                    {
                        summary.Add(new TestCaseResult(tc, TestStatus.Error, $"Setup failed: {ex.Message}"));
                    }
                    continue;
                }

                var tasks = new List<Task>();

                foreach (var testCase in group)
                {
                    await semaphore.WaitAsync();

                    var task = Task.Run(async () =>
                    {
                        try
                        {
                            var result = await ExecuteTestCase(instance, testCase);
                            summary.Add(result);
                        }
                        finally
                        {
                            semaphore.Release();
                        }
                    });

                    tasks.Add(task);
                }

                await Task.WhenAll(tasks);

                // cleanup method
                try
                {
                    await processCleanup(testClassType, instance);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Cleanup ERROR: {ex.Message}");
                }
            }

            globalStopwatch.Stop();

            int passed = summary.Count(s => s.Status == TestStatus.Passed);
            int failed = summary.Count(s => s.Status == TestStatus.Failed);
            int skipped = summary.Count(s => s.Status == TestStatus.Ignored);
            int error = summary.Count(s => s.Status == TestStatus.Error);

            Console.WriteLine();
            Console.WriteLine($"Total: {summary.Count}, Passed: {passed}, Failed: {failed}, Skipped: {skipped}, Error: {error}");
            Console.WriteLine($"Total duration: {globalStopwatch.Elapsed}");

            PrintTimeline(summary);

            return 0;
        }

        private static async Task<TestCaseResult> ExecuteTestCase(object instance, TestCase testCase)
        {
            var stopwatch = Stopwatch.StartNew();

            var threadId = Thread.CurrentThread.ManagedThreadId;
            var processId = Process.GetCurrentProcess().Id;
            var startOffset = _globalClock.Elapsed;

            try
            {
                // IGNORE
                if (testCase.Ignore)
                {
                    PrintYellow(
                        $"[IGNORED] {testCase.TestName} | PID: {processId} | Thread: {threadId} | Reason: {testCase.IgnoreReason}"
                    );

                    return new TestCaseResult(testCase, TestStatus.Ignored, testCase.IgnoreReason, TimeSpan.Zero, startOffset);
                }

                // TIMEOUT
                var timeoutAttr = testCase.Method.GetCustomAttribute<TestTimeoutAttribute>();
                int timeout = timeoutAttr?.Milliseconds ?? Timeout.Infinite;
                
                var testTask = Task.Run(() =>
                    InvokeSyncOrAsync(testCase.Method, instance, testCase.Arguments)
                );
                
                if (timeout != Timeout.Infinite)
                {
                    var completed = await Task.WhenAny(Task.Delay(timeout), testTask);

                    if (completed != testTask)
                        throw new TestTimeoutException(timeout);
                }

                await testTask;

                stopwatch.Stop();

                PrintGreen(
                    $"[PASSED] {testCase.TestName} | PID: {processId} | Thread: {threadId} | Start(+): {startOffset} | Duration: {stopwatch.Elapsed}"
                );

                return new TestCaseResult(testCase, TestStatus.Passed, null, stopwatch.Elapsed, startOffset);
            }
            catch (Exception ex)
            {
                stopwatch.Stop();

                var realEx = ex is TargetInvocationException tie ? tie.InnerException! : ex;

                if (realEx is AssertException)
                {
                    PrintRed(
                        $"[FAILED] {testCase.TestName} - {realEx.Message} | PID: {processId} | Thread: {threadId} | Start(+): {startOffset} | Duration: {stopwatch.Elapsed}"
                    );

                    return new TestCaseResult(testCase, TestStatus.Failed, realEx.Message, stopwatch.Elapsed, startOffset);
                }

                if (realEx is TestTimeoutException)
                {
                    PrintRed(
                        $"[TIMEOUT] {testCase.TestName} | PID: {processId} | Thread: {threadId} | Start(+): {startOffset} | Duration: {stopwatch.Elapsed}"
                    );

                    return new TestCaseResult(testCase, TestStatus.Failed, realEx.Message, stopwatch.Elapsed, startOffset);
                }

                PrintDarkRed(
                    $"[ERROR] {testCase.TestName} - {realEx.Message} | PID: {processId} | Thread: {threadId} | Start(+): {startOffset} | Duration: {stopwatch.Elapsed}"
                );

                return new TestCaseResult(testCase, TestStatus.Error, realEx.Message, stopwatch.Elapsed, startOffset);
            }
        }

        private static void PrintTimeline(IEnumerable<TestCaseResult> results)
        {
            Console.WriteLine();
            Console.WriteLine("Timeline:");
            Console.WriteLine("ID   Timeline");

            var ordered = results.OrderBy(r => r.StartOffset).ToList();
            if (!ordered.Any()) return;

            var minStart = ordered.Min(r => r.StartOffset);
            var maxEnd = ordered.Max(r => r.StartOffset + r.Duration);

            var totalMs = (maxEnd - minStart).TotalMilliseconds;

            int width = 50;
            int id = 1;

            foreach (var r in ordered)
            {
                var startMs = (r.StartOffset - minStart).TotalMilliseconds;
                var durMs = r.Duration.TotalMilliseconds;

                int offset = (int)(startMs / totalMs * width);
                int length = Math.Max(1, (int)(durMs / totalMs * width));

                string line = new string(' ', offset) + new string('#', length);

                Console.WriteLine($"{id,-4} {line}");
                id++;
            }
        }

        private static async Task InvokeSyncOrAsync(MethodInfo method, object instance, object[]? args = null)
        {
            args ??= Array.Empty<object>();

            var result = method.Invoke(instance, args);

            if (result is Task t) await t;
            else if (result is ValueTask vt) await vt;
        }

        private static async Task processSetup(Type type, object instance)
        {
            var m = type.GetMethods(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)
                .FirstOrDefault(x => x.GetCustomAttribute<TestSetupAttribute>() != null);

            if (m != null) await InvokeSyncOrAsync(m, instance);
        }

        private static async Task processCleanup(Type type, object instance)
        {
            var m = type.GetMethods(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)
                .FirstOrDefault(x => x.GetCustomAttribute<TestClearSetupAttribute>() != null);

            if (m != null) await InvokeSyncOrAsync(m, instance);
        }

        // output

        private static void PrintGreen(string msg)
        {
            lock (_consoleLock)
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine(msg);
                Console.ResetColor();
            }
        }

        private static void PrintRed(string msg)
        {
            lock (_consoleLock)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine(msg);
                Console.ResetColor();
            }
        }

        private static void PrintDarkRed(string msg)
        {
            lock (_consoleLock)
            {
                Console.ForegroundColor = ConsoleColor.DarkRed;
                Console.WriteLine(msg);
                Console.ResetColor();
            }
        }

        private static void PrintYellow(string msg)
        {
            lock (_consoleLock)
            {
                Console.ForegroundColor = ConsoleColor.Yellow;
                Console.WriteLine(msg);
                Console.ResetColor();
            }
        }

        private static string getDllPath()
        {
            Console.WriteLine("Enter dll path:");
            return Console.ReadLine()!;
        }

        private static bool tryLoadAssembly(string path, out Assembly? asm)
        {
            try
            {
                asm = Assembly.LoadFrom(path);
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"ERROR: {ex.Message}");
                asm = null;
                return false;
            }
        }

        private static Type[]? getTestClasses(Assembly asm)
        {
            return asm.GetTypes()
                .Where(t => t.GetCustomAttribute<TestClassAttribute>() != null)
                .ToArray();
        }

        private static List<TestCase> getAllTestCases(Type[] types)
        {
            var list = new List<TestCase>();

            foreach (var type in types)
            {
                var methods = type.GetMethods(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)
                    .Where(m => m.GetCustomAttribute<TestAttribute>() != null);

                foreach (var m in methods)
                {
                    var ignoreAttr = m.GetCustomAttribute<TestIgnoreAttribute>();
                    var priorityAttr = m.GetCustomAttribute<TestPriorityAttribute>();
                    var descriptionAttr = m.GetCustomAttribute<TestDescriptionAttribute>();
                    var paramAttrs = m.GetCustomAttributes<TestWithParamsAttribute>().ToArray();

                    if (!paramAttrs.Any())
                    {
                        list.Add(new TestCase
                        {
                            TestClassType = type,
                            Method = m,
                            Arguments = Array.Empty<object>(),
                            Ignore = ignoreAttr != null,
                            IgnoreReason = ignoreAttr?.IgnoreReason,
                            Priority = priorityAttr?.Priority ?? TestPriority.P_MEDIUM,
                            TestDescription = descriptionAttr?.Description
                        });
                    }
                    else
                    {
                        foreach (var p in paramAttrs)
                        {
                            list.Add(new TestCase
                            {
                                TestClassType = type,
                                Method = m,
                                Arguments = p.Parameters,
                                Ignore = ignoreAttr != null,
                                IgnoreReason = ignoreAttr?.IgnoreReason,
                                Priority = priorityAttr?.Priority ?? TestPriority.P_MEDIUM,
                                TestDescription = descriptionAttr?.Description
                            });
                        }
                    }
                }
            }

            return list;
        }
    }
}