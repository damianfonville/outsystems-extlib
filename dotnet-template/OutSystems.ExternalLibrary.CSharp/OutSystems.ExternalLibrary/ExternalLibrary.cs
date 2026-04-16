using Microsoft.Extensions.Logging;
using System.Diagnostics;

namespace OutSystems.ExternalLibrary;

public sealed class ExternalLibrary : IExternalLibrary
{
    private static readonly ActivitySource ActivitySource = new("OutSystems.ExternalLibrary");
    private readonly ILogger<ExternalLibrary> _logger;

    public ExternalLibrary(ILogger<ExternalLibrary> logger)
    {
        _logger = logger;
    }

    public string SayHello(string name, string title = "Mr./Ms.")
    {
        using var activity = ActivitySource.StartActivity(nameof(SayHello));
        _logger.LogInformation("Saying hello to {Name} with title {Title}", name, title);
        return $"Hello, {title} {name}";
    }

    public string SayGoodbye(string name)
    {
        using var activity = ActivitySource.StartActivity(nameof(SayGoodbye));
        _logger.LogInformation("Saying goodbye to {Name}", name);
        return $"Goodbye, {name}";
    }
}
