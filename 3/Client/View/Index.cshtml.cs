using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace WebApplication.Pages
{
    public class IndexModel : PageModel
    {
        [BindProperty]
        public string Text { get; set; }
        public Dictionary<string, int> dict;

        public void OnGet()
        {
            var client = new WordCounter.WordCounter();
            dict = client.ParallelStart(Text);

        }
    }
}