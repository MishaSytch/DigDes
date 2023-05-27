using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WordCounter;


public class IndexModel : PageModel
{
    [BindProperty]
    public string Text { get; set; } = "Null null null Hello world hello Hello";
    public Dictionary<string, int> dict = new Dictionary<string, int>();

    public void OnGet()
    {
        var client = new WordCounter.WordCounter();
        dict = client.ParallelStart(Text);
    }
}
