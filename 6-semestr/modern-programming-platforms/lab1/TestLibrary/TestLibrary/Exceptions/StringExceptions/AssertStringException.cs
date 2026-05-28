namespace TestLibrary.Exceptions;

public class AssertStringException: AssertException
{
    public AssertStringException(string message)
        : base(message)
    {
    }
}