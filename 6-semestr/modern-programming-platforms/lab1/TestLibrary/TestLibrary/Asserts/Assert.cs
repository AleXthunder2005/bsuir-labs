using System.Collections;
using TestLibrary.Exceptions;

namespace TestLibrary.Asserts;

  public static class Assert
    {
        //simple methods
        public static void AreEqual<T>(T expected, T actual)
        {
            if (!Equals(expected, actual))
                throw new AssertEqualException(expected, actual);
        }

        public static void AreNotEqual<T>(T notExpected, T actual)
        {
            if (Equals(notExpected, actual))
                throw new AssertNotEqualException(actual);
        }

        public static void IsTrue(bool condition)
        {
            if (!condition)
                throw new AssertException("Condition is false but expected true.");
        }

        public static void IsFalse(bool condition)
        {
            if (condition)
                throw new AssertException("Condition is true but expected false.");
        }

        public static void IsNull(object obj)
        {
            if (obj != null)
                throw new AssertException("Object is not null.");
        }

        public static void IsNotNull(object obj)
        {
            if (obj == null)
                throw new AssertException("Object is null.");
        }

        //string methods
        public static void Contains(string substring, string actual)
        {
            if (actual == null || !actual.Contains(substring))
                throw new AssertContainsException(substring, actual);
        }

        public static void DoesNotContain(string substring, string actual)
        {
            if (actual != null && actual.Contains(substring))
                throw new AssertDoesNotContainException(substring, actual);
        }

        //comparison methods
        public static void Greater<T>(T actual, T threshold)
            where T : IComparable<T>
        {
            if (actual.CompareTo(threshold) <= 0)
                throw new AssertComparisonException<T>(
                    "greater than",
                    threshold,
                    actual);
        }

        public static void Less<T>(T actual, T threshold)
            where T : IComparable<T>
        {
            if (actual.CompareTo(threshold) >= 0)
                throw new AssertComparisonException<T>(
                    "less than",
                    threshold,
                    actual);
        }

        public static void GreaterOrEqual<T>(T actual, T threshold)
            where T : IComparable<T>
        {
            if (actual.CompareTo(threshold) < 0)
                throw new AssertComparisonException<T>(
                    "greater or equal to",
                    threshold,
                    actual);
        }

        public static void LessOrEqual<T>(T actual, T threshold)
            where T : IComparable<T>
        {
            if (actual.CompareTo(threshold) > 0)
                throw new AssertComparisonException<T>(
                    "less or equal to",
                    threshold,
                    actual);
        }
        
        //collection methods
        public static void IsEmpty(IEnumerable collection)
        {
            if (collection.Cast<object>().Any())
                throw new AssertEmptyCollectionException(collection);
        }

        public static void IsNotEmpty(IEnumerable collection)
        {
            if (!collection.Cast<object>().Any())
                throw new AssertNotEmptyCollectionException();
        }
        
        public static void ContainsElement<T>(T element, IEnumerable collection)
        {
            foreach (var item in collection)
            {
                if (Equals(item, element))
                    return; 
            }

            throw new AssertContainsElemException(element, collection);
        }

        public static void DoesNotContainElement<T>(T element, IEnumerable collection)
        {
            foreach (var item in collection)
            {
                if (Equals(item, element))
                    throw new AssertDoesNotContainElemException(element, collection);
            }
        }
        
        //throws methods 
        public static void Throws<TException>(Action action) where TException : Exception
        {
            try
            {
                action();
            }
            catch (Exception ex)
            {
                if (ex is TException)
                    return;

                throw new AssertThrowsException(typeof(TException), ex.GetType());
            }

            throw new AssertThrowsException(typeof(TException), null);
        }
    }