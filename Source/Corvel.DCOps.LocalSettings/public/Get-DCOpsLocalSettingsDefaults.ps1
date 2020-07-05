function Get-DCOpsLocalSettingsDefaults {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param ()
    return $script:DefaultValues
 }