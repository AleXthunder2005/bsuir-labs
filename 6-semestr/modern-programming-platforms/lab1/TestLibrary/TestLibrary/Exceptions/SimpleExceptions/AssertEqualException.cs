namespace TestLibrary.Exceptions;

public class AssertEqualException : AssertException
{
    public AssertEqualException(object expected, object actual)
        : base($"Expected: {expected}, but got: {actual}")
    {
    }
}