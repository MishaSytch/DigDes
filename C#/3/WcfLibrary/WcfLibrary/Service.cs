using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace WcfLibrary
{
    // ПРИМЕЧАНИЕ. Команду "Переименовать" в меню "Рефакторинг" можно использовать для одновременного изменения имени класса "Service" в коде и файле конфигурации.
    public class Service : IService
    {
        public Dictionary<string, int> GetCount(string text)
        {
            WordCounter.WordCounter wordCounter = new WordCounter.WordCounter();
            return wordCounter.ParallelStart(text);
        }
    }
}
