﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WordCounter

{
    public class WordCounter
    {
        private Dictionary<string, int> _words = new Dictionary<string, int>();

        private Dictionary<string, int> Count(string _text)
        {
            string[] strings = _text.Trim().Split(' ');
            for (int i = 0; i < strings.Length; i++)
            {
                string tmp = strings[i];

                StringBuilder variable = new StringBuilder();
                foreach (var letter in tmp)
                    if (char.IsLetter(letter) || letter.Equals("'") || letter.Equals("-") && variable.ToString().Length != 0) //Регулярку вставить бы
                        variable.Append(letter);
                if (variable.ToString().Trim().Length == 0) continue;
                if (_words.ContainsKey(variable.ToString()))
                {
                    _words[variable.ToString()]++;
                }
                else
                {
                    _words.Add(variable.ToString(), 1);
                }
            }
            return _words;
        }
    }
}
