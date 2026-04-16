param(
    [string]$ProjectName = "Contoso.ExternalLibrary"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$packageProject = Join-Path $repoRoot "OutSystems.ExternalLibrary.Template.csproj"
$artifactsRoot = Join-Path $repoRoot "artifacts"
$tempRoot = Join-Path $repoRoot ".tmp"
$workRoot = Join-Path $tempRoot "outsystems-external-library-dotnet-template-smoke"
$hiveRoot = Join-Path $tempRoot "outsystems-external-library-dotnet-template-hive"
$solutionPath = Join-Path $workRoot "$ProjectName.slnx"

function Invoke-LoggedCommand {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,

        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    $rendered = ($Arguments | ForEach-Object {
        if ($_ -match '\s') { '"' + $_ + '"' } else { $_ }
    }) -join ' '

    Write-Host "[SmokeTest] Executing: $FilePath $rendered"
    & $FilePath @Arguments
}

Write-Host "[SmokeTest] Repo root: $repoRoot"
Write-Host "[SmokeTest] Package project: $packageProject"
Write-Host "[SmokeTest] Artifacts root: $artifactsRoot"
Write-Host "[SmokeTest] Work root: $workRoot"
Write-Host "[SmokeTest] Hive root: $hiveRoot"

if (Test-Path $workRoot) {
    Write-Host "[SmokeTest] Removing existing work root"
    Remove-Item -Recurse -Force $workRoot
}

if (Test-Path $hiveRoot) {
    Write-Host "[SmokeTest] Removing existing template hive"
    Remove-Item -Recurse -Force $hiveRoot
}

if (-not (Test-Path $tempRoot)) {
    Write-Host "[SmokeTest] Creating temp root"
    New-Item -ItemType Directory -Path $tempRoot | Out-Null
}

Write-Host "[SmokeTest] Creating work root"
New-Item -ItemType Directory -Path $workRoot | Out-Null

$package = Get-ChildItem -Path $artifactsRoot -Filter "*.nupkg" -File | Select-Object -First 1

if (-not $package) {
    throw "No NuGet package was created."
}

Write-Host "[SmokeTest] Installing template package"
Invoke-LoggedCommand -FilePath "dotnet" -Arguments @(
    "new",
    "install",
    $package.FullName,
    "--force",
    "--debug:custom-hive",
    $hiveRoot
)

Write-Host "[SmokeTest] Creating project from template"
Invoke-LoggedCommand -FilePath "dotnet" -Arguments @(
    "new",
    "outsystems-extlib",
    "-n",
    $ProjectName,
    "-o",
    $workRoot,
    "--debug:custom-hive",
    $hiveRoot
)

Write-Host "[SmokeTest] Generated files:"
Get-ChildItem -Path $workRoot -Recurse | Select-Object FullName

if (-not (Test-Path $solutionPath)) {
    throw "Generated solution file was not found: $solutionPath"
}

Write-Host "[SmokeTest] Solution file contents:"
Get-Content $solutionPath

Write-Host "[SmokeTest] Restoring generated solution"
Invoke-LoggedCommand -FilePath "dotnet" -Arguments @(
    "restore",
    $solutionPath
)

Write-Host "[SmokeTest] Building generated solution"
Invoke-LoggedCommand -FilePath "dotnet" -Arguments @(
    "build",
    $solutionPath,
    "--configuration",
    "Release",
    "--no-restore"
)

Write-Host "[SmokeTest] Testing generated solution"
Invoke-LoggedCommand -FilePath "dotnet" -Arguments @(
    "test",
    $solutionPath,
    "--configuration",
    "Release",
    "--no-build",
    "--verbosity",
    "normal"
)

Write-Host "[SmokeTest] Completed successfully"
