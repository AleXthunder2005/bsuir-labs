using System.Collections;

namespace TestLibrary.Exceptions;

public class AssertContainsElemException : AssertCollectionException
{
    public AssertContainsElemException(object expectedElement, IEnumerable actualCollection)
        : base($"Expected collection to contain element '{expectedElement}', " +
               $"but it was not found. Collection: [{string.Join(", ", actualCollection)}]")
    {
    }
}