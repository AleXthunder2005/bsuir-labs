namespace TestLibrary.Exceptions;

public class AssertThrowsException : AssertException
{
    public AssertThrowsException(Type expected, Type actual)
        : base(actual == null
            ? $"Expected exception {expected.Name}, but no exception was thrown."
            : $"Expected exception {expected.Name}, but got {actual.Name}.")
    {
    }
}