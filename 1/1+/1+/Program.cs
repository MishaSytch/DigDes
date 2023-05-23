internal class Program
{
    private static void Main(string[] args)
    {
        var construct = (No)typeof(RuntimeTypeHandle).GetMethod("Allocate", System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.NonPublic).Invoke(null, new object[] { typeof(No) });
        typeof(No).GetConstructor(Type.EmptyTypes).Invoke(construct, new object[0]);
    }
}
abstract class No
{
    public string _name;

    public No()
    {
        _name = "Go away!";
    }

    public abstract void ab();
}
