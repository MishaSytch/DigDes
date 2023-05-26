using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace WordCounter

{
    public class WordCounter
    {
        private Dictionary<string, int> _words = new Dictionary<string, int>();
        private object _lock = new object();

        private Dictionary<string, int> Count(string _text)
        {
            string[] strings = _text.Trim().Split(' ');
            for (int i = 0; i < strings.Length; i++)
            {
                string tmp = strings[i];

                StringBuilder variable = new StringBuilder();
                foreach (var letter in tmp)
                    if (char.IsLetter(letter) || letter.Equals("'")) //Регулярку вставить бы
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
        public Dictionary<string, int> ParallelStart(string _text)
        {
            Parallel.ForEach(_text.Split(' '), PCount);

            return _words;
        }


        private void PCount(string word)
        {
            lock (_lock)
            {
                StringBuilder variable = new StringBuilder();
                foreach (var letter in word)
                    if (char.IsLetter(letter) || letter.Equals("'")) //Регулярку вставить бы
                        variable.Append(letter);
                if (variable.ToString().Trim().Length != 0)
                {
                    if (_words.ContainsKey(variable.ToString()))
                    {
                        _words[variable.ToString()]++;
                    }
                    else
                    {
                        _words.Add(variable.ToString(), 1);
                    }
                }
            }
        }
    }
}
