using TestLibrary.Constants;

namespace TestLibrary.Attributes;

public class TestPriorityAttribute : Attribute
{
    public TestPriority Priority { get; }
    
    public TestPriorityAttribute(TestPriority priority) => Priority = priority;
}