namespace TestLibrary.Exceptions;

public class AssertNotEmptyCollectionException : AssertCollectionException
{
    public AssertNotEmptyCollectionException()
        : base("Expected collection NOT to be empty, but it was empty.")
    {
    }
}