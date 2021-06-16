#region REMOVE_CODE
# Code in this region will be removed during the build process and the function scripts
# in the 'private' and 'public' subfolders will be inserted in its place.
# Functions from the 'public' folder being added to 'FunctionsToExport' setting of the module.
# Code outside of the region will be preserved.

#region LOAD_SCRIPTS
$ModulePath = $MyInvocation.MyCommand.Path
$ExportedFunctions = @()
$ModuleFile = Split-Path $ModulePath -Leaf
$ModuleName = $ModuleFile -replace '.psm1',''
$ModuleRoot = Join-Path (Split-Path $ModulePath) $ModuleName
if (-not (Test-Path $ModuleRoot)) {
    $ModuleRoot = Split-Path $ModulePath
}
# Load and export public functions
if (Test-Path "$ModuleRoot\public") {
    $Scripts = Get-ChildItem -Path "$ModuleRoot\public" -Filter "*.ps1"
    foreach ($ScriptFile in $Scripts) {  
        . $ScriptFile.FullName
        $ExportedFunctions += $ScriptFile.BaseName
    }
}

# Load private functions
if (Test-Path "$ModuleRoot\private") {
    $Scripts = Get-ChildItem -Path "$ModuleRoot\private" -Filter '*.ps1'
    foreach ($ScriptFile in $Scripts) {
        . $ScriptFile.FullName
    }
}

Export-ModuleMember -Function $ExportedFunctions
#endregion LOAD_SCRIPTS
#endregion REMOVE_CODE


$BinFolder = Join-Path $PSScriptRoot 'bin'
$Binaries = Get-ChildItem -Path $BINFolder -Filter '*.exe' -File
foreach ($Binary in $Binaries) {
    New-Alias -Name $Binary.BaseName -Value $Binary.FullName -Scope Global -Force 
}

$PathFolders = ($env:PATH -split ';' | Where-Object {$_ -ne ''}) -replace '"', ''

$global:GNUPLOTINSTALLED = $false
foreach ($Folder in $PathFolders) {
    if (Test-Path (Join-Path $Folder 'gnuplot.exe')) {
        New-Alias -Name 'gnuplot' -Value (Join-Path $Folder 'gnuplot.exe') -Scope Global -Force 
        $global:GNUPLOTINSTALLED = $true
        break
    }    
}

if ($global:GNUPLOTINSTALLED -eq $false) {
    # The GNUPLOT install doesn't always add itself to the path, so we'll brute force it
    if (Test-Path (Join-Path $env:ProgramFiles 'gnuplot\bin\gnuplot.exe')) {
        New-Alias -Name 'gnuplot' -Verbose (Join-Path $env:ProgramFiles 'gnuplot\bin\gnuplot.exe') -Scope Global -Force
        $global:GNUPLOTINSTALLED = $true
    } elseif (Test-Path (Join-Path ${env:ProgramFiles(x86)} 'gnuplot\bin\gnuplot.exe')) {
        New-Alias -Name 'gnuplot' -Value (Join-Path ${env:ProgramFiles(x86)} 'gnuplot\bin\gnuplot.exe') -Scope Global -Force
        $global:GNUPLOTINSTALLED = $true
    }
}

if ($global:GNUPLOTINSTALLED) {
    New-Alias -Name 'New-GnuPlotImage' -Value 'Invoke-GnuPlot' -Scope Global -Force
}

$global:NAVISECCLIINSTALLED = $false
foreach ($Folder in $PathFolders) {
    if (Test-Path (Join-Path $Folder 'naviseccli.exe')) {
        New-Alias -Name 'naviseccli' -Value (Join-Path $Folder 'naviseccli.exe') -Scope Global -Force 
        $global:NAVISECCLIINSTALLED = $true
        break
    }
}
