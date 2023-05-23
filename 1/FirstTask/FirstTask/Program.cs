﻿using System;
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
                WordCounter.WordCounter wordCounter = new WordCounter.WordCounter(_text.ToString());
                var reflectMeth = wordCounter.GetType().GetMethod("Count", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                var reflectField = wordCounter.GetType().GetField("_text", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                var text = reflectField.GetValue(wordCounter);
                var dict = reflectMeth.Invoke(wordCounter, new object[0]);
            }
        }
    }
}