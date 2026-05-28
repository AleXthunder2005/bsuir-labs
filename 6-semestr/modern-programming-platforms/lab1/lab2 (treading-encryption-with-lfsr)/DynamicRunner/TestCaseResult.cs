namespace DynamicPoolTestRunner
{
    public class TestCaseResult
    {
        public TestCase TestCase { get; }
        public TestStatus Status { get; }
        public string? Message { get; }
        public TimeSpan Duration { get; }
        public TimeSpan StartOffset { get; }

        public TestCaseResult(TestCase testCase, TestStatus status, string? message = null, TimeSpan? duration = null, TimeSpan? startOffset = null)
        {
            TestCase = testCase;
            Status = status;
            Message = message;
            Duration = duration ?? TimeSpan.Zero;
            StartOffset = startOffset ?? TimeSpan.Zero;
        }
    }
}
