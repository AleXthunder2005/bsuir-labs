namespace TestLibrary.Attributes;

[AttributeUsage(AttributeTargets.Method)]
public class TestTimeoutAttribute : Attribute
{
    public int Milliseconds { get; }

    public TestTimeoutAttribute(int milliseconds)
    {
        Milliseconds = milliseconds;
    }
}