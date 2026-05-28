namespace TestLibrary.Attributes;

public class TestIgnoreAttribute : Attribute
{
    public string IgnoreReason { get; set; }
    
    public TestIgnoreAttribute(string ignoreReason = "")
    {
        IgnoreReason = ignoreReason;            
    }
}