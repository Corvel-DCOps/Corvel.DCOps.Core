function Get-DCOpsLocalSettingsDefaults {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param ()
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    return $script:DefaultValues.Clone()
 }