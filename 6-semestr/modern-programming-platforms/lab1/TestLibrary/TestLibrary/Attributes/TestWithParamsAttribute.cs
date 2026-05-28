namespace TestLibrary.Attributes;

[AttributeUsage(AttributeTargets.Method, AllowMultiple = true)]
public class TestWithParamsAttribute: Attribute
{
    public object[] Parameters { get; }

    public TestWithParamsAttribute(object[] parameters)
    {
        Parameters = parameters;
    } 
}