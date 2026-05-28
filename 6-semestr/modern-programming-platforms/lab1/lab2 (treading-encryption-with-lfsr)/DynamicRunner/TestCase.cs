using System.Reflection;
using TestLibrary.Constants;

namespace DynamicPoolTestRunner
{
    public class TestCase
    {
        public Type TestClassType { get; init; } = null!;
        public MethodInfo Method { get; init; } = null!;
        public object[] Arguments { get; init; } = Array.Empty<object>();
        public TestPriority Priority { get; init; } = TestPriority.P_MEDIUM;
        public bool Ignore { get; init; } = false;
        
        public string? IgnoreReason { get; init; }
        
        public string? TestDescription { get; init; }
        
        public string? Category { get; init; }
        
        public string? Author { get; init; }
        
        public string TestName => $"{TestClassType.Name}.{Method.Name}({string.Join(", ", Arguments.Select(a => a?.ToString() ?? "null"))})";
    }
}
