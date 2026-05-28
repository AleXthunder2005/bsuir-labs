namespace TestLibrary.Attributes;

public class TestDescriptionAttribute : Attribute
{
    public string Description { get; }
    
    public TestDescriptionAttribute(string description) => Description = description;
}