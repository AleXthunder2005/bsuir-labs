namespace TestLibrary.Exceptions;

public class AssertComparisonException<T> : AssertException
    where T : IComparable<T>
{
    public T Expected { get; }
    public T Actual { get; }
    public string Comparison { get; }

    public AssertComparisonException(string comparison, T expected, T actual)
        : base($"Expected value {comparison} {expected}, but got {actual}.")
    {
        Comparison = comparison;
        Expected = expected;
        Actual = actual;
    }
}