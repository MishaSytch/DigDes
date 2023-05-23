class Program 
{
    static void Main(string[] args) 
    {
        ReflactionExp();
    }

    private static void ReflactionExp()
    {
        var classInstance = new MyClass();
        classInstance.PublicInt = 10;
        Console.WriteLine(classInstance.PublicInt);

        var type = typeof(MyClass); // Этап трансляции
        var typeRuntime = classInstance.GetType(); // рантайм

        var fieldInfo = type.GetField("PrivateString", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance); 
        var stringValue = fieldInfo.GetValue(classInstance) as string;
        Console.WriteLine(stringValue);

        var fieldInfoType = fieldInfo.GetType();
        var fieldInfoMeths = fieldInfoType.GetMethods();

        var members = type.GetMembers()
            .Where(M => M.GetCustomAttributes()
                .Any(a => a.GetType() == typeof(XmlElementAttribute)));
    }
}

public class MyClass 
{
    [XmlElement]
    public int PublicInt;

    private string PrivateString = "asd";

    public string PublicMeth() 
    {
        return nameof(PublicMeth);
    }

    private string PrivateMeth() 
    {
        return nameof(PrivateMeth);
    }
}