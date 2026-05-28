namespace TestLibrary.Attributes;

public class TestCategoryAttribute : Attribute
{
    public string Category { get; }
    
    public TestCategoryAttribute(string category)
    {
        Category = category;
    }
}