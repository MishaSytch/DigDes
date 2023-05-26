using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WordCounter;


public class IndexModel : PageModel
{
    [BindProperty]
    public string Text { get; set; }
    public Dictionary<string, int> dict;

    public void OnGet()
    {
        var client = new WordCounter.WordCounter();
        var dict = client.ParallelStart(Text);
    }
}
