namespace TestRunner
{
    class TestCaseResult
    {
        public TestCase TestCase { get; }
        public TestStatus Status { get; }
        public string? Message { get; }
        public TimeSpan Duration { get; }

        public TestCaseResult(TestCase tc, TestStatus status, string? message = null, TimeSpan? duration = null)
        {
            TestCase = tc;
            Status = status;
            Message = message;
            Duration = duration ?? TimeSpan.Zero;
        }
    }
}
