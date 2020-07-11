# HashTable containing the default values if a saved value isn't found.
# Not all possible values are here.
$script:DefaultValues = @{
    dcopserver = 'https://dcops.corvel.com'
    dcopdbserver = 'hbdcdcops02'
    maxjsondatacacheage = '900'
 }
 $script:LocalSettingsFile = "$env:APPDATA\Corvel.DCOps\localsettings.json"

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
#endregion LoadScripts


