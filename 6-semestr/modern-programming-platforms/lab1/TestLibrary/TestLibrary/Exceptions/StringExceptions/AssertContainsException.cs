namespace TestLibrary.Exceptions;

public class AssertContainsException : AssertStringException
{
    public AssertContainsException(string expected, string actual)
        : base($"Expected string to contain '{expected}', but got '{actual}'")
    {
    }
}