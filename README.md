# OutSystems External Library Template

A `dotnet new` template for creating an OutSystems external library solution in C#.

The template creates a ready-to-build solution with:

- A .NET 8 external library project
- A companion NUnit test project
- A `.slnx` solution file

## Prerequisites

- .NET SDK 8.0 or later

Check your installed SDKs with:

```powershell
dotnet --list-sdks
```

## Install From NuGet

Install the template package from NuGet:

```powershell
dotnet new install dfonville.OutSystems.ExternalLibrary.Template
```

Confirm that the template is available:

```powershell
dotnet new list outsystems
```

The template short name is:

```text
outsystems-extlib
```

## Create a New External Library

Create a solution from the template:

```powershell
dotnet new outsystems-extlib -n Contoso.ExternalLibrary.HelloWorld
```

This creates a new directory named `Contoso.ExternalLibrary.HelloWorld` because the template uses the project name as the output directory by default.

Build and test the generated solution:

```powershell
cd .\Contoso.ExternalLibrary.HelloWorld
dotnet restore .\Contoso.ExternalLibrary.HelloWorld.slnx
dotnet build .\Contoso.ExternalLibrary.HelloWorld.slnx
dotnet test .\Contoso.ExternalLibrary.HelloWorld.slnx
```

## Generated Structure

For this command:

```powershell
dotnet new outsystems-extlib -n Contoso.ExternalLibrary.HelloWorld
```

the template generates:

```text
Contoso.ExternalLibrary.HelloWorld/
|-- Contoso.ExternalLibrary.HelloWorld.slnx
|-- Contoso.ExternalLibrary.HelloWorld/
|   |-- Contoso.ExternalLibrary.HelloWorld.csproj
|   |-- ExternalLibrary.cs
|   `-- IExternalLibrary.cs
`-- Contoso.ExternalLibrary.HelloWorld.Tests/
    |-- Contoso.ExternalLibrary.HelloWorld.Tests.csproj
    `-- ExternalLibraryTests.cs
```

Project names, namespaces, and the solution file name are derived from the value passed with `-n`.

## Update or Uninstall the Template

Update the installed template to the latest available NuGet version:

```powershell
dotnet new update
```

Uninstall the template:

```powershell
dotnet new uninstall dfonville.OutSystems.ExternalLibrary.Template
```

## Local Development

Install the template directly from this repository while developing it:

```powershell
dotnet new install .\dotnet-template\OutSystems.ExternalLibrary.CSharp
```

Create a project using the local template:

```powershell
dotnet new outsystems-extlib -n Contoso.ExternalLibrary.HelloWorld
```

Uninstall the locally installed template:

```powershell
dotnet new uninstall .\dotnet-template\OutSystems.ExternalLibrary.CSharp
```

## Package the Template

Create a NuGet package:

```powershell
dotnet pack --configuration Release OutSystems.ExternalLibrary.Template.csproj --output .\artifacts
```

Install the generated package locally:

```powershell
dotnet new install .\artifacts\dfonville.OutSystems.ExternalLibrary.Template.0.1.0-local.nupkg
```

Use the actual `.nupkg` file name from the `artifacts` directory when the version differs.

## Test the Template

Run the smoke test:

```powershell
.\build\Invoke-DotNetTemplateSmokeTest.ps1
```

The smoke test:

- Packs the template into a NuGet package
- Installs it into a temporary custom template hive
- Generates a sample external library solution
- Runs `dotnet restore`
- Runs `dotnet build`
- Runs `dotnet test`

## CI and Release

Pull request builds run `.github/workflows/pr.yml`, which:

- Computes a pull request package version
- Packs the template
- Runs the smoke test
- Uploads the `.nupkg` as a workflow artifact

Release builds run `.github/workflows/release.yml` on pushes to `main`, which:

- Creates or bumps a Git tag
- Packs the template with the generated version
- Runs the smoke test
- Creates a GitHub release
- Pushes the package to NuGet

## Package Details

- Package ID: `dfonville.OutSystems.ExternalLibrary.Template`
- Template short name: `outsystems-extlib`
- Template identity: `dfonville.OutSystems.ExternalLibraries.CSharp.Cli`
- Template source directory: `dotnet-template/OutSystems.ExternalLibrary.CSharp`
- Package project: `OutSystems.ExternalLibrary.Template.csproj`
