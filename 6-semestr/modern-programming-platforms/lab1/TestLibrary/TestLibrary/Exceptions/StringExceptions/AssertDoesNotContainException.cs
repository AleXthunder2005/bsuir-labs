namespace TestLibrary.Exceptions;

public class AssertDoesNotContainException : AssertStringException
{
    public AssertDoesNotContainException(string forbidden, string actual)
        : base($"Expected string NOT to contain '{forbidden}', but it was found in '{actual}'.")
    {
    }
}