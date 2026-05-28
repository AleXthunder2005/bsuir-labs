using TestLibrary.Asserts;
using TestLibrary.Attributes;
using TestLibrary.Constants;
using TestLibrary.SharedContext;
using theory_information_lab2;

namespace ProjectFunctionalityTests
{
    [TestClass]
    public class TestModelFunctions
    {
        // setup
        [TestSetup]
        public void Setup()
        {
            ModelFunctions.StartParsePolynom();

            SharedContextStore.Register("BinaryText", "11110000");
        }

        [TestClearSetup]
        public void ClearSetup()
        {
            SharedContextStore.Unregister("BinaryText");
        }

        // simple asserts
        [Test]
        [TestDescription("Is length of some string less than max allowed length")]
        [TestPriority(TestPriority.P_HIGH)]
        [TestAuthor("Ivan Petrov")]
        [TestCategory("SimpleAsserts")]
        public void IsLengthSuitable_ReturnsTrue()
        {
            bool result = ModelFunctions.IsLengthSuitable(5, 10);
            Assert.IsTrue(result);
            Assert.AreEqual(true, result);
            Assert.AreNotEqual(false, result);
        }

        [Test]
        [TestDescription("Is entered char one of the binary chars ('1' or '0')")]
        [TestPriority(TestPriority.P_LOW)]
        [TestAuthor("Maria Sidorova")]
        [TestCategory("SimpleAsserts")]
        public void IsKeyBinaryDigit_Test()
        {
            Assert.IsTrue(ModelFunctions.IsKeyBinaryDigit('0'));
            Assert.IsTrue(ModelFunctions.IsKeyBinaryDigit('1'));
            Assert.IsFalse(ModelFunctions.IsKeyBinaryDigit('2'));
        }

        // string asserts
        [Test]
        [TestDescription("Does EraseSplitters method cut off splitters correctly")]
        [TestTimeout(500)]
        [TestAuthor("Ivan Petrov")]
        [TestCategory("StringAsserts")]
        public void EraseSplitters_Test()
        {
            string result = ModelFunctions.EraseSpliters("1111_0000_");
            Assert.AreEqual("11110000", result);
            Assert.DoesNotContain("_", result);
            Assert.Contains("1111", result);
        }

        // collection asserts
        [Test]
        [TestDescription("Does ParsePolynom return numbers of active bits properly")]
        [TestAuthor("Alexey Smirnov")]
        [TestCategory("CollectionAsserts")]
        public void ParsePolynom_Test()
        {
            const string testPolynom = "x^40 + x^21 + x^19 + x^2 + 1";
            byte[] bits = ModelFunctions.ParsePolynom(testPolynom);

            Assert.IsNotNull(bits);
            Assert.IsNotEmpty(bits);
            Assert.ContainsElement((byte)40, bits);
            Assert.DoesNotContainElement((byte)5, bits);
        }

        [Test]
        [TestDescription("Check expected empty collection")]
        [TestAuthor("Maria Sidorova")]
        [TestCategory("CollectionAsserts")]
        public void EmptyCollection_Test()
        {
            var list = new List<int>();
            Assert.IsEmpty(list);
        }

        // comparison asserts
        [Test]
        [TestDescription("Does ConvertTextToLong return long register value from text string")]
        [TestAuthor("Ivan Petrov")]
        [TestCategory("ComparisonAsserts")]
        public async Task ConvertTextToLong_Test()
        {
            long value = ModelFunctions.ConvertTextToLong("00000001");

            Assert.Greater(value, 0);
            Assert.LessOrEqual(value, 255);
            Assert.GreaterOrEqual(value, 1);
            Assert.AreEqual(1L, value);
        }

        // throws asserts
        [Test]
        [TestDescription("Incorrect polynom as input parameter of ParsePolynom method")]
        [TestAuthor("Alexey Smirnov")]
        [TestCategory("ExceptionAsserts")]
        public void ParsePolynom_ShouldThrow()
        {
            /*  Assert.Throws<FormatException>(() =>
                {
                    ModelFunctions.ParsePolynom("x^A + x^B");
                });
            */
            ModelFunctions.ParsePolynom("x^A + x^B");
        }

        // test with parameters
        /*[Test]
        [TestDescription("ConvertTextToLong with parameteres")]
        [TestAuthor("Maria Sidorova")]
        [TestCategory("ParameterizedTests")]
        [TestWithParams(new object[] { "00000001", 1L })]
        [TestWithParams(new object[] { "00000101", 1L})]
        public void ConvertTextToLong_WithParams(string text, long expected)
        {
            long result = ModelFunctions.ConvertTextToLong(text);
            Assert.AreEqual(expected, result);
        }*/
        
        // test with generator
        [Test]
        [TestDescription("ConvertTextToLong with generator")]
        [TestAuthor("Maria Sidorova")]
        [TestCategory("WithGenerator")]
        [TestWithGenerator(typeof(ConvertTextToLongGenerator), nameof(ConvertTextToLongGenerator.GenerateConvertTextToLongParams))]
        public void ConvertTextToLong_WithGenerator(string text, long expected)
        {
            long result = ModelFunctions.ConvertTextToLong(text);
            Assert.AreEqual(expected, result);
        }

        // shared context
        [Test]
        [TestDescription("check SharedContext values")]
        [TestAuthor("Ivan Petrov")]
        [TestCategory("Integration")]
        public void SharedContext_Test()
        {
            bool ok = SharedContextStore.TryGet<string>("BinaryText", out var text);
            Assert.IsTrue(ok);
            Assert.IsNotNull(text);
            Assert.Contains("1111", text);
        }

        // ignore tests
        [Test]
        [TestIgnore("It is wrong test, that's why ignore it yet")]
        [TestAuthor("Alexey Smirnov")]
        [TestCategory("Ignored")]
        public void GenerateKey_Test()
        {
            var key = ModelFunctions.GenerateKey("11110000", 4);
            Assert.IsNotNull(key);
        }
    }
}