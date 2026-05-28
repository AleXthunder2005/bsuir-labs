using System.Collections;

namespace TestLibrary.Exceptions;

public class AssertDoesNotContainElemException : AssertCollectionException
{
    public AssertDoesNotContainElemException(object forbiddenElement, IEnumerable actualCollection)
        : base($"Expected collection NOT to contain element '{forbiddenElement}', " +
               $"but it was found. Collection: [{string.Join(", ", actualCollection)}]")
    {
    }
}