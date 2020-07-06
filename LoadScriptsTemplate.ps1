#region LoadScripts
$ModulePath = $MyInvocation.MyCommand.Path
$ExportedFunctions = @()
$ModuleFile = Split-Path $ModulePath -Leaf
$ModuleName = $ModuleFile -replace '.psm1',''
$ModuleRoot = Join-Path (Split-Path $ModulePath) $ModuleName
if (-not (Test-Path $ModuleRoot)) {
    $ModuleRoot = Split-Path $ModulePath
}
# Load and export public functions
$Scripts = Get-ChildItem -Path "$ModuleRoot\public" -Filter "*.ps1"
foreach ($ScriptFile in $Scripts) {
    . $ScriptFile.FullName
    $ExportedFunctions += $ScriptFile.BaseName
}

# Load private functions
$Scripts = Get-ChildItem -Path "$ModuleRoot\private" -Filter '*.ps1'
foreach ($ScriptFile in $Scripts) {
    . $ScriptFile.FullName
}
Export-ModuleMember -Function $ExportedFunctions
#endregion LoadScripts

