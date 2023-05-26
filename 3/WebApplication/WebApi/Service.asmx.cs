using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using WordCounter;

namespace WebApi
{
    /// <summary>
    /// Сводное описание для Service
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Чтобы разрешить вызывать веб-службу из скрипта с помощью ASP.NET AJAX, раскомментируйте следующую строку. 
    // [System.Web.Script.Services.ScriptService]
    public class Service : System.Web.Services.WebService
    {

        [WebMethod]
        public Dictionary<string, int> Count(string text)
        {
            WordCounter.WordCounter wordCounter = new WordCounter.WordCounter();
            Dictionary<string, int> dict = wordCounter.ParallelStart(text.ToString());
            return dict;
        }
    }
}
