using System.ServiceModel;

namespace Service
{
    class Program
    {
        private static void Main()
        {
            using (var serviceHost = new System.ServiceModel.ServiceHost(typeof(WcfLibrary.Service)))
            {
                serviceHost.Open();

                Console.WriteLine("host open");
                Console.ReadLine();
            };
        }
    }
}