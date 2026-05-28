namespace TestLibrary.Attributes;

public class TestAuthorAttribute : Attribute
{
    public string Author { get; }
    
    public TestAuthorAttribute(string author)
    {
        Author = author;
    }
}