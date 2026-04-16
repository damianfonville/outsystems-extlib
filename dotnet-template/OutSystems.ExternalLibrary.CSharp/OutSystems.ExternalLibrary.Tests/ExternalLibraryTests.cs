using NUnit.Framework;
using Microsoft.Extensions.Logging.Abstractions;

namespace OutSystems.ExternalLibrary.Tests;

[TestFixture]
public class ExternalLibraryTests
{
    [Test]
    public void SayHello_ReturnsGreetingWithTitle()
    {
        var sut = new OutSystems.ExternalLibrary.ExternalLibrary(new NullLogger<OutSystems.ExternalLibrary.ExternalLibrary>());

        var result = sut.SayHello("Jane", "Dr.");

        Assert.That(result, Is.EqualTo("Hello, Dr. Jane"));
    }

    [Test]
    public void SayGoodbye_ReturnsFarewell()
    {
        var sut = new OutSystems.ExternalLibrary.ExternalLibrary(new NullLogger<OutSystems.ExternalLibrary.ExternalLibrary>());

        var result = sut.SayGoodbye("Jane");

        Assert.That(result, Is.EqualTo("Goodbye, Jane"));
    }
}
