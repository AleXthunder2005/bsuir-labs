namespace TestLibrary.Exceptions;

public class AssertException : Exception
{
    public AssertException(string message) : base(message)
    {
    }
}