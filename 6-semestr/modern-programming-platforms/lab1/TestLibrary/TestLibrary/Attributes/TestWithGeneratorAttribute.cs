namespace TestLibrary.Attributes;

[AttributeUsage(AttributeTargets.Method, AllowMultiple = false)]
public class TestWithGeneratorAttribute : Attribute
{
    public Type GeneratorClassType { get; }
    public string GeneratorMethodName { get; }
    
    public TestWithGeneratorAttribute(Type generatorClassType, string generatorMethodName)
    {
        GeneratorClassType = generatorClassType;
        GeneratorMethodName = generatorMethodName;
    }
}