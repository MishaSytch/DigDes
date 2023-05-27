using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();


app.MapGet("/WordCounter", (string text) =>
{
    var wordCounter = new WordCounter.WordCounter();
    var dict = wordCounter.ParallelStart(text);

    StringBuilder str = new StringBuilder();
    foreach (string word in dict.Keys) str.AppendLine(String.Format("{0,-24} {1}", word, dict[word]));
    return str.ToString();
})
.WithName("Counter");

app.MapPost("/Count", (string text) =>
{
    var wordCounter = new WordCounter.WordCounter();
    var dict = wordCounter.ParallelStart(text);

    StringBuilder str = new StringBuilder();
    foreach (string word in dict.Keys) str.AppendLine(String.Format("{0,-24} {1}", word, dict[word]));
    return str.ToString();
}).WithName("Count");

app.Run();
