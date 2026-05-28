namespace TestLibrary.Exceptions;

public class AssertCollectionException : AssertException
{
    public AssertCollectionException(string message)
        : base(message)
    {
    }
}