using System;
using System.Collections.Generic;

namespace ProjectFunctionalityTests;

public static class ConvertTextToLongGenerator
{
    public static IEnumerable<object[]> GenerateConvertTextToLongParams()
    {
        yield return new object[] { "00000000", 0L };
        yield return new object[] { "00000001", 1L };
        yield return new object[] { "00000010", 2L };
        yield return new object[] { "00000101", 5L };
        yield return new object[] { "00001010", 10L };
        yield return new object[] { "00010001", 17L };
        yield return new object[] { "00100010", 34L };
        yield return new object[] { "01010101", 85L };
        yield return new object[] { "10101010", 170L };
        yield return new object[] { "11111111", 255L };
    }
}