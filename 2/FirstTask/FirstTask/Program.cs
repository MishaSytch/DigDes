using System;
using System.Diagnostics;
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
                Stopwatch stopWatch = new Stopwatch();
                stopWatch.Start();
                Dictionary<string, int> dict = (Dictionary<string, int>)reflectMeth.Invoke(wordCounter, new object[] {_text.ToString()});
                stopWatch.Stop();
                TimeSpan ts = stopWatch.Elapsed;
                string notParallelTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
                    ts.Hours, ts.Minutes, ts.Seconds,
                    ts.Milliseconds / 10);

                wordCounter = new WordCounter.WordCounter();
                stopWatch = new Stopwatch();
                stopWatch.Start();
                dict = wordCounter.ParallelStart(_text.ToString()); 
                stopWatch.Stop();
                ts = stopWatch.Elapsed;
                string parallelTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
                    ts.Hours, ts.Minutes, ts.Seconds,
                    ts.Milliseconds / 10);
                
                using (StreamWriter streamWriter = File.CreateText($"{path}/time.txt"))
                {
                    streamWriter.WriteLine($"Parallel Time: {parallelTime}\n");
                    streamWriter.WriteLine($"Not Parallel Time: {notParallelTime}");
                }
                StringBuilder str = new StringBuilder();
                foreach (string word in dict.Keys) str.AppendLine(String.Format("{0,-24} {1}", word, dict[word]));
                using (StreamWriter streamWriter = File.CreateText($"{path}/count.txt"))
                {
                    streamWriter.WriteLine(str);
                }
            }
        }
    }
}