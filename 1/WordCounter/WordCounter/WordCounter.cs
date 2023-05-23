using System;
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

                string variable = "";
                foreach (var letter in tmp)
                    if (char.IsLetter(letter) || letter.Equals("'")) //Регулярку вставить бы
                        variable += letter;
                if (variable.Trim().Length == 0) continue;
                if (_words.ContainsKey(variable))
                {
                    _words[variable]++;
                }
                else
                {
                    _words.Add(variable, 1);
                }
            }
            return _words;
        }
    }
}
