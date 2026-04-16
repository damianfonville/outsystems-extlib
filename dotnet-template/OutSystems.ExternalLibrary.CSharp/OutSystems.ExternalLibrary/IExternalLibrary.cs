using OutSystems.ExternalLibraries.SDK;

namespace OutSystems.ExternalLibrary;

[OSInterface]
public interface IExternalLibrary
{
    string SayHello(string name, string title);
    string SayGoodbye(string name);
}
