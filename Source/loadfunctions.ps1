function Load-Function {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseApprovedVerbs', '')]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$ModulePath
    )
    $ModuleFile = Split-Path $ModulePath -Leaf
    $ModuleName = $ModuleFile -replace '.psm1',''
    $ModuleRoot = Join-Path (Split-Path $ModulePath) $ModuleName

    # Load and export public functions
    $Scripts = Get-ChildItem -Path "$ModuleRoot\public" -Filter "*.ps1"
    foreach ($ScriptFile in $Scripts) {
        Write-Verbose "Loading and exporting public script '$(Split-Path $ScriptFile -Leaf)'"
        . $ScriptFile.FullName
        Export-ModuleMember $ScriptFile.BaseName -Verbose -ErrorAction Stop
    }

    # Load private functions
    $Scripts = Get-ChildItem -Path "$ModuleRoot\private" -Filter '*.ps1'
    foreach ($ScriptFile in $Scripts) {
        Write-Verbose "Loading private script '$(Split-Path $ScriptFile -Leaf)'"
        . $ScriptFile.FullName
    }

}