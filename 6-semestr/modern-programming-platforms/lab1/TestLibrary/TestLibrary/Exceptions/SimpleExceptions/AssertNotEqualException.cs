namespace TestLibrary.Exceptions;

public class AssertNotEqualException : AssertException
{
    public AssertNotEqualException(object actual)
        : base($"Expected values to be different, but both were '{actual}'.")
    {
    }
}