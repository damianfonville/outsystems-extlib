## Summary

Describe the change in a few sentences.

## What Changed

- [ ] Template source files
- [ ] Generated solution structure
- [ ] Test project behavior
- [ ] Smoke test script
- [ ] NuGet package metadata or versioning
- [ ] GitHub Actions workflow
- [ ] Documentation

## Generated Output Impact

What changes for someone who runs:

```powershell
dotnet new outsystems-extlib -n Contoso.ExternalLibrary.HelloWorld
```

Include any changes to:

- generated files or folders
- namespaces
- test project behavior
- package/install behavior

## Validation

- [ ] Ran `.\build\Invoke-DotNetTemplateSmokeTest.ps1`
- [ ] Verified `dotnet new install .\dotnet-template\OutSystems.ExternalLibrary.CSharp`
- [ ] Verified `dotnet new outsystems-extlib -n Contoso.ExternalLibrary.HelloWorld`
- [ ] Verified generated solution builds
- [ ] Verified generated solution tests pass
- [ ] Verified package creation with `dotnet pack --configuration Release OutSystems.ExternalLibrary.Template.csproj`

## Versioning Impact

- [ ] No package versioning impact
- [ ] Affects CI package version behavior
- [ ] Affects release tag version behavior
- [ ] Affects package ID or install path

Details:

## Release Notes

What should be called out in release notes, if anything?

## Checklist

- [ ] I updated documentation if needed
- [ ] I kept the generated template output coherent
- [ ] I checked for breaking changes in the generated solution
