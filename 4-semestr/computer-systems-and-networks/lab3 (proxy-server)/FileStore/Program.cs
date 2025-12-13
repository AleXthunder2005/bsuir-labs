using FileStore;

var builder = WebApplication.CreateBuilder(new WebApplicationOptions()
{
    WebRootPath = "storage"
});

var app = builder.Build();
Directory.CreateDirectory("storage");
string storageRoot = Path.Combine(Directory.GetCurrentDirectory(), "storage");
StorageService storageService = new StorageService(storageRoot);

//catch-all параметр
app.MapGet("/{**path}", (string? path) => storageService.Get(path));  //позволяет задать обработчик для гет запросов, если URL соответствует шаблону (/все что угодно)
app.MapPut("/{**path}", async (HttpContext context, string path) => await storageService.Put(context, path));
app.MapDelete("/{**path}", (string path) => storageService.Delete(path));
app.MapMethods("/{**path}", new string[] { "HEAD" }, (HttpContext context, string path) => storageService.Head(context, path));

app.Run();