using System.Collections;

namespace TestLibrary.Exceptions;

public class AssertEmptyCollectionException : AssertCollectionException
{
    public AssertEmptyCollectionException(IEnumerable actualCollection)
        : base($"Expected collection to be empty, but it contains elements: " +
               $"[{string.Join(", ", actualCollection)}]")
    {
    }
}