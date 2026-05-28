using System.Collections.Concurrent;
using System.Diagnostics;
using System.Reflection;
using DynamicPoolTestRunner;
using DynamicThreadPoolModule;
using TestLibrary.Attributes;
using TestLibrary.Constants;
using TestLibrary.Exceptions;

namespace DynamicRunner
{
    public class Program
    {
        private const string? FILTER_AUTHOR = "Maria Sidorova"; // null
        private const string? FILTER_CATEGORY = null; // null
        
        private static readonly object _consoleLock = new();
        private static int _totalRuns = 60;

        static async Task Main(string[] args)
        {
            Console.WriteLine("Dynamic ThreadPool Test Runner");
            Console.WriteLine("Example of dll path:");
            Console.WriteLine(@"C:\6-semestr\modern-programming-platforms\lab1\lab2 (treading-encryption-with-lfsr)\ProjectFunctionalityTests\bin\Debug\net9.0\ProjectFunctionalityTests.dll");
            Console.WriteLine("--------------------------------------------------");
            
            Console.Write("Enter path to test DLL: ");
            string? dllPath = Console.ReadLine()?.Trim('"', ' ');
            
            if (string.IsNullOrEmpty(dllPath) || !File.Exists(dllPath))
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine($"Error: DLL file not found at path: {dllPath}");
                Console.ResetColor();
                return;
            }

            // Создаем пул потоков с оптимальными настройками
            using var pool = new DynamicThreadPool<TestCaseResult>(
                minWorkers: 2,
                maxWorkers: 8,
                idleTimeout: TimeSpan.FromSeconds(3),
                queuePressureTimeout: TimeSpan.FromMilliseconds(500),
                hungWorkerTimeout: TimeSpan.FromSeconds(5),
                supervisorInterval: TimeSpan.FromMilliseconds(500)
            );
            
            Action<PoolSnapshot> snapshotHandler = snapshot =>
            {
                lock (_consoleLock)
                {
                    Console.ForegroundColor = ConsoleColor.Magenta;
                    Console.WriteLine($"[STATE CHANGED] Time: {DateTime.Now:HH:mm:ss.fff}");
                    Console.WriteLine($"  Workers: {snapshot.TotalWorkers} (Min: {snapshot.MinWorkers}, Max: {snapshot.MaxWorkers})");
                    Console.WriteLine($"  Busy: {snapshot.BusyWorkers}, Idle: {snapshot.IdleWorkers}");
                    Console.WriteLine($"  Queue Length: {snapshot.QueuedItems}");
                    
                    // Логируем причины изменения на основе текущего состояния
                    if (snapshot.BusyWorkers == snapshot.TotalWorkers && snapshot.QueuedItems > 0)
                        Console.WriteLine($"  Status: FULL LOAD - All workers busy, {snapshot.QueuedItems} tasks waiting");
                    else if (snapshot.IdleWorkers > 0 && snapshot.QueuedItems == 0)
                        Console.WriteLine($"  Status: IDLE - {snapshot.IdleWorkers} workers idle");
                    else if (snapshot.BusyWorkers < snapshot.TotalWorkers && snapshot.QueuedItems > 0)
                        Console.WriteLine($"  Status: PROCESSING - {snapshot.BusyWorkers}/{snapshot.TotalWorkers} workers busy");
                    else if (snapshot.TotalWorkers > snapshot.MinWorkers && snapshot.IdleWorkers > 0)
                        Console.WriteLine($"  Status: SCALING DOWN - {snapshot.IdleWorkers} idle workers available");
                    
                    Console.ResetColor();
                }
            };
            // Подписываемся на событие изменения состояния пула
            pool.StateChanged += snapshotHandler;

            // Загружаем тесты из указанной сборки
            var assembly = Assembly.LoadFrom(dllPath);
            var allTests = LoadTestsFromAssembly(assembly);
            
            // Фильтруем тесты
            var testsToRun = allTests.Where(test => ShouldRunTest(test, FILTER_AUTHOR, FILTER_CATEGORY)).ToList();
            
            // Выводим отфильтрованные тесты
            PrintFilteredTests(testsToRun);
            
            if (!testsToRun.Any())
            {
                Console.WriteLine("No tests match the filter criteria.");
                return;
            }

            var summary = new ConcurrentBag<TestCaseResult>();
            var handles = new List<PoolHandle<TestCaseResult>>();
            var globalStopwatch = Stopwatch.StartNew();

            // Запускаем модуляцию нагрузки
            await ProduceLoad(pool, testsToRun, _totalRuns, handles);

            // Собираем результаты
            foreach (var handle in handles)
            {
                try
                {
                    summary.Add(await handle.Completion);
                }
                catch (Exception ex)
                {
                    SafeWriteLine($"[ERROR] {ex.Message}", ConsoleColor.Red);
                }
            }

            globalStopwatch.Stop();
            pool.Stop();
            
            // Выводим отчет
            PrintReport(summary.ToList(), globalStopwatch.Elapsed);
            pool.StateChanged -= snapshotHandler;
        }

        private static List<TestCase> LoadTestsFromAssembly(Assembly assembly)
        {
            var allTests = new List<TestCase>();
            
            foreach (var type in assembly.GetTypes())
            {
                if (!type.IsClass || !type.IsPublic || type.GetCustomAttribute<TestClassAttribute>() == null)
                    continue;

                foreach (var method in type.GetMethods(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly))
                {
                    var testAttr = method.GetCustomAttribute<TestAttribute>();
                    if (testAttr == null) continue;

                    // Получаем атрибуты
                    var priorityAttr = method.GetCustomAttribute<TestPriorityAttribute>();
                    var ignoreAttr = method.GetCustomAttribute<TestIgnoreAttribute>();
                    var descriptionAttr = method.GetCustomAttribute<TestDescriptionAttribute>();
                    var categoryAttr = method.GetCustomAttribute<TestCategoryAttribute>();
                    var authorAttr = method.GetCustomAttribute<TestAuthorAttribute>();
                    var generatorAttr = method.GetCustomAttribute<TestWithGeneratorAttribute>();

                    // Проверяем наличие генератора
                    if (generatorAttr != null)
                    {
                        try
                        {
                            var generatorMethod = generatorAttr.GeneratorClassType.GetMethod(
                                generatorAttr.GeneratorMethodName,
                                BindingFlags.Public | BindingFlags.Static); 
                            
                            // если есть генератор
                            if (generatorMethod != null && generatorMethod.ReturnType == typeof(IEnumerable<object[]>))
                            {
                                var parametersList = (IEnumerable<object[]>)generatorMethod.Invoke(null, null);
                                
                                foreach (var parameters in parametersList)
                                {
                                    allTests.Add(new TestCase
                                    {
                                        TestClassType = type,
                                        Method = method,
                                        Arguments = parameters,
                                        Priority = priorityAttr?.Priority ?? TestPriority.P_MEDIUM,
                                        Ignore = ignoreAttr != null,
                                        IgnoreReason = ignoreAttr?.IgnoreReason,
                                        TestDescription = descriptionAttr?.Description,
                                        Category = categoryAttr?.Category,
                                        Author = authorAttr?.Author
                                    });
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            SafeWriteLine($"Error creating generated tests: {ex.Message}", ConsoleColor.Red);
                        }
                    }
                    else
                    {
                        // если переданы параметры в аттрибуте
                        var paramsAttrs = method.GetCustomAttributes<TestWithParamsAttribute>().ToList();
                        if (paramsAttrs.Any())
                        {
                            foreach (var paramsAttr in paramsAttrs)
                            {
                                allTests.Add(new TestCase
                                {
                                    TestClassType = type,
                                    Method = method,
                                    Arguments = paramsAttr.Parameters,
                                    Priority = priorityAttr?.Priority ?? TestPriority.P_MEDIUM,
                                    Ignore = ignoreAttr != null,
                                    IgnoreReason = ignoreAttr?.IgnoreReason,
                                    TestDescription = descriptionAttr?.Description,
                                    Category = categoryAttr?.Category,
                                    Author = authorAttr?.Author
                                });
                            }
                        }
                        else
                        {
                            // обычные тесты без параметров
                            allTests.Add(new TestCase
                            {
                                TestClassType = type,
                                Method = method,
                                Arguments = Array.Empty<object>(),
                                Priority = priorityAttr?.Priority ?? TestPriority.P_MEDIUM,
                                Ignore = ignoreAttr != null,
                                IgnoreReason = ignoreAttr?.IgnoreReason,
                                TestDescription = descriptionAttr?.Description,
                                Category = categoryAttr?.Category,
                                Author = authorAttr?.Author
                            });
                        }
                    }
                }
            }
            
            return allTests;
        }

        private static async Task ProduceLoad(
            DynamicThreadPool<TestCaseResult> pool,
            List<TestCase> tests,
            int totalRuns,
            List<PoolHandle<TestCaseResult>> handles)
        {
            var rnd = new Random();

            for (int i = 0; i < totalRuns; i++)
            {
                string phase =
                    i < totalRuns * 0.2 ? "IDLE" :
                    i < totalRuns * 0.5 ? "RAMP-UP" :
                    i < totalRuns * 0.8 ? "PEAK" :
                    "COOLDOWN";

                SafeWriteLine($"\n=== PHASE: {phase} (Run {i + 1}/{totalRuns}) ===", ConsoleColor.Cyan);

                int batchSize =
                    phase == "IDLE" ? 0 :
                    phase == "RAMP-UP" ? 2 :
                    phase == "PEAK" ? 6 : 1;

                if (batchSize > 0)
                {
                    EnqueueBatch(pool, tests, handles, batchSize, rnd);
                }
                else
                {
                    SafeWriteLine("  No tasks enqueued (IDLE phase)", ConsoleColor.DarkGray);
                }

                int delayMs = phase == "IDLE" ? 800 :
                              phase == "RAMP-UP" ? 300 :
                              phase == "PEAK" ? 100 : 500;

                await Task.Delay(delayMs);
            }
        }

        private static void EnqueueBatch(
            DynamicThreadPool<TestCaseResult> pool,
            List<TestCase> tests,
            List<PoolHandle<TestCaseResult>> handles,
            int batchSize,
            Random rnd)
        {
            for (int i = 0; i < batchSize; i++)
            {
                var test = tests[rnd.Next(tests.Count)];
                var priority = GetPriorityValue(test.Priority);
                
                var handle = pool.Enqueue(
                    () => ExecuteTest(test),
                    priority,
                    test.TestName
                );

                handles.Add(handle);
            }
            
            SafeWriteLine($"  Enqueued {batchSize} tasks", ConsoleColor.DarkGray);
        }

        private static TestCaseResult ExecuteTest(TestCase testCase)
        {
            var stopwatch = Stopwatch.StartNew();
            var threadId = Thread.CurrentThread.ManagedThreadId;

            try
            {
                if (testCase.Ignore)
                {
                    stopwatch.Stop();
                    SafeWriteLine($"[IGNORED] {testCase.TestName}", ConsoleColor.Yellow);
                    return new TestCaseResult(testCase, TestStatus.Ignored, testCase.IgnoreReason, stopwatch.Elapsed);
                }

                // Создаем экземпляр тестового класса
                var instance = Activator.CreateInstance(testCase.TestClassType);
                
                // Выполняем Setup методы
                var setupMethods = testCase.TestClassType.GetMethods()
                    .Where(m => m.GetCustomAttribute<TestSetupAttribute>() != null);
                
                foreach (var setup in setupMethods)
                {
                    setup.Invoke(instance, null);
                }

                // Выполняем тест
                var result = testCase.Method.Invoke(instance, testCase.Arguments);
                
                // Обрабатываем Task результат
                if (result is Task task)
                {
                    task.GetAwaiter().GetResult();
                }

                // Выполняем ClearSetup методы
                var clearMethods = testCase.TestClassType.GetMethods()
                    .Where(m => m.GetCustomAttribute<TestClearSetupAttribute>() != null);
                
                foreach (var clear in clearMethods)
                {
                    clear.Invoke(instance, null);
                }

                stopwatch.Stop();
                
                SafeWriteLine($"[PASS] {testCase.TestName} | Thread={threadId} | {stopwatch.ElapsedMilliseconds}ms", ConsoleColor.Green);
                return new TestCaseResult(testCase, TestStatus.Passed, null, stopwatch.Elapsed);
            }
            catch (Exception ex)
            {
                stopwatch.Stop();
                var realException = ex.InnerException ?? ex;
                
                var color = realException is AssertException ? ConsoleColor.Red : ConsoleColor.DarkRed;
                var status = realException is AssertException ? TestStatus.Failed : TestStatus.Error;
                
                SafeWriteLine($"[{(status == TestStatus.Failed ? "FAIL" : "ERROR")}] {testCase.TestName} | {realException.Message}", color);
                return new TestCaseResult(testCase, status, realException.Message, stopwatch.Elapsed);
            }
        }

        private static bool ShouldRunTest(TestCase test, string? filterAuthor, string? filterCategory)
        {
            // Фильтрация по автору
            if (!string.IsNullOrEmpty(filterAuthor))
            {
                if (string.IsNullOrEmpty(test.Author))
                    return false;
                    
                if (!test.Author.Trim().Equals(filterAuthor.Trim(), StringComparison.OrdinalIgnoreCase))
                    return false;
            }

            // Фильтрация по категории
            if (!string.IsNullOrEmpty(filterCategory))
            {
                if (string.IsNullOrEmpty(test.Category))
                    return false;
                    
                if (!test.Category.Trim().Equals(filterCategory.Trim(), StringComparison.OrdinalIgnoreCase))
                    return false;
            }

            return true;
        }

        private static void PrintFilteredTests(List<TestCase> filteredTests)
        {
            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.WriteLine("\n========== FILTERED TESTS TO RUN ==========");
            Console.ResetColor();
            
            var methodCounter = new Dictionary<string, int>();
            
            foreach (var test in filteredTests)
            {
                Console.ForegroundColor = ConsoleColor.Cyan;
                
                string displayName = test.TestName;
                
                if (!methodCounter.ContainsKey(test.Method.Name))
                    methodCounter[test.Method.Name] = 0;
                
                methodCounter[test.Method.Name]++;
                
                var totalMethodTests = filteredTests.Count(t => t.Method.Name == test.Method.Name);
                if (totalMethodTests > 1)
                {
                    displayName = $"{test.TestName}_generated_{methodCounter[test.Method.Name]}";
                }
                
                Console.Write($"  • {displayName}");
                
                if (!string.IsNullOrEmpty(test.Author))
                    Console.Write($"\n      Author: {test.Author}");
                
                if (!string.IsNullOrEmpty(test.Category))
                    Console.Write($"\n      Category: {test.Category}");
                
                Console.Write($"\n      Priority: {test.Priority}");
                
                if (!string.IsNullOrEmpty(test.TestDescription))
                    Console.Write($"\n      Description: {test.TestDescription}");
                
                if (test.Arguments.Length > 0)
                {
                    Console.Write($"\n      Arguments: ({string.Join(", ", test.Arguments.Select(a => a?.ToString() ?? "null"))})");
                }
                
                Console.WriteLine("\n");
                Console.ResetColor();
            }
            
            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.WriteLine($"Total unique test methods: {filteredTests.Select(t => t.Method.Name).Distinct().Count()}");
            Console.WriteLine($"Total test cases (including generated): {filteredTests.Count}");
            Console.WriteLine($"Total runs (with load modulation): {_totalRuns}");
            Console.WriteLine("===========================================\n");
            Console.ResetColor();
        }

        private static int GetPriorityValue(TestPriority priority)
        {
            return priority switch
            {
                TestPriority.P_HIGH => 10,
                TestPriority.P_MEDIUM => 5,
                TestPriority.P_LOW => 1,
                _ => 5
            };
        }

        private static void PrintReport(List<TestCaseResult> results, TimeSpan duration)
        {
            Console.WriteLine("\n========== TEST EXECUTION REPORT ==========");
            
            var passed = results.Count(r => r.Status == TestStatus.Passed);
            var failed = results.Count(r => r.Status == TestStatus.Failed);
            var ignored = results.Count(r => r.Status == TestStatus.Ignored);
            var errors = results.Count(r => r.Status == TestStatus.Error);
            var total = results.Count;

            Console.WriteLine($"Total Executions: {total}");
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine($"Passed: {passed}");
            Console.ResetColor();
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"Failed: {failed}");
            Console.WriteLine($"Errors: {errors}");
            Console.ResetColor();
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine($"Ignored: {ignored}");
            Console.ResetColor();
            Console.WriteLine($"Total Duration: {duration}");

            if (failed > 0 || errors > 0)
            {
                Console.WriteLine("\n--- FAILED/ERROR TESTS (First 10) ---");
                foreach (var result in results.Where(r => r.Status == TestStatus.Failed || r.Status == TestStatus.Error).Take(10))
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine($"  • {result.TestCase.TestName}");
                    Console.WriteLine($"    {result.Message}");
                    Console.ResetColor();
                }
                
                if (results.Count(r => r.Status == TestStatus.Failed || r.Status == TestStatus.Error) > 10)
                {
                    Console.WriteLine($"  ... and {results.Count(r => r.Status == TestStatus.Failed || r.Status == TestStatus.Error) - 10} more");
                }
            }

            Console.WriteLine("===========================================\n");
        }
        
        private static void SafeWriteLine(string msg, ConsoleColor? color = null)
        {
            lock (_consoleLock)
            {
                if (color.HasValue) Console.ForegroundColor = color.Value;
                Console.WriteLine($" [{DateTime.Now:HH:mm:ss.fff}] {msg}");
                if (color.HasValue) Console.ResetColor();
            }
        }
    }
}