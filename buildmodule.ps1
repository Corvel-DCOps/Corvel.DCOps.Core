[CmdletBinding()]
param (
	[switch]$IgnoreBranch,
	[string]$BuildRoot = 'C:\data\synodrive\dev\build'
)

$CurrentBranch = git rev-parse --abbrev-ref HEAD
if ($CurrentBranch -ne 'main') {
	if ($IgnoreBranch -eq $true) {
		Write-Warning "Not on main branch (Current Branch: $CurrentBranch)"
	} else {
		Write-Host "ERROR: Not on main branch (Current Branch: $CurrentBranch)" -ForegroundColor Red
		Exit
	}
}

Push-Location $PSScriptRoot
$ModuleFile =  (Split-Path . -Leaf) + '.psd1'
if (!(Test-Path $ModuleFile)) {
	Write-Host "Unable to locate module file '$ModuleFile' - aborting!" -ForegroundColor Red
	Pop-Location
	Exit
}

$ModuleManifest = Test-ModuleManifest $ModuleFile -ErrorAction SilentlyContinue -Verbose:$false
if ($null -eq $ModuleManifest) {
	Write-Host "Module file '$ModuleFile' is not a valide PowerShell module - aborting!" -ForegroundColor Red
	Pop-Location
	Exit
}
$CurrentVersion = $ModuleManifest.Version

Write-Host "Setting up build folder(s)..." -ForegroundColor Cyan
$BuildFolder = Join-Path (Join-Path $BuildRoot $ModuleManifest.Name) $CurrentVersion.ToString()
if (Test-Path $BuildFolder) { Remove-Item $BuildFolder -Recurse -ErrorAction SilentlyContinue -Force }
New-Item -Path $BuildFolder -Force -ItemType Directory | Out-Null
Write-Host "Copying Module Manfifest..." -ForegroundColor Cyan
Copy-Item $ModuleFile (Join-Path $BuildFolder $ModuleFile)
Write-Host "Copying Nested Modules..." -ForegroundColor Cyan
foreach ($Module in $ModuleManifest.NestedModules) {
	$SourceFile = $Module.Path
	Write-Host "Copying '$(Resolve-Path $SourceFile -Relative)'" -ForegroundColor Cyan
	Copy-Item $SourceFile -Destination $BuildFolder
}
# Get-ChildItem *.psm1 | ForEach-Object {Copy-Item $_.Name (Join-Path $BuildFolder $_.Name)}
Write-Host "Copying additional files..." -ForegroundColor Cyan
foreach ($FileItem in $ModuleManifest.FileList) {
	$SourceFile = Resolve-Path $FileItem -Relative
	Write-Host "Copying '$SourceFile'" -ForegroundColor Cyan
	$DestFolder = Join-Path $BuildFolder (Split-Path $SourceFile -Parent)
	New-Item $DestFolder -ItemType Directory -Force | Out-Null
	Copy-Item $SourceFile -Destination $DestFolder 
}

Pop-Location
Write-Host "Done!" -ForegroundColor Cyan
