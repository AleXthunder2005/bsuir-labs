namespace TestLibrary.Exceptions;

public class TestTimeoutException : Exception
{
    public TestTimeoutException(int ms)
        : base($"Test exceeded timeout of {ms} ms")
    {
    }
}