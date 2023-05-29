using System;
using System.IO;
using System.Text;

namespace Program
{
    internal class Program
    {
        public static void Main(string[] args)
        {
            Console.Write("Введите директроию файла (сепаратор = '/'): ");
            string path = Console.ReadLine().Trim();
            Console.Write("Введите имя файла с разрешением: ");
            string name = Console.ReadLine().Trim();

            using (StreamReader streamReader = new StreamReader($"{path}/{name}"))
            {
                StringBuilder _text = new StringBuilder();
                string line = "";
                while ((line = (streamReader.ReadLine())) != null)
                {
                    _text.Append(line).Append(" ");
                }
                WordCounter.WordCounter wordCounter = new WordCounter.WordCounter();
                var reflectMeth = wordCounter.GetType().GetMethod("Count", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                Dictionary<string, int> dict = (Dictionary<string, int>)reflectMeth.Invoke(wordCounter, new object[] {_text.ToString()});

                StringBuilder str = new StringBuilder();
                foreach (string word in dict.Keys) str.AppendLine(String.Format("{0,-24} {1}\n", word, dict[word]));
                using (StreamWriter streamWriter = File.CreateText($"{path}/count.txt"))
                {
                    streamWriter.WriteLine(str);
                }
            }
            }
    }
}