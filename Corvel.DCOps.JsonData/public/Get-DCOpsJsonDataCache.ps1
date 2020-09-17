function Get-DCOpsJsonDataCache {
    [CmdletBinding()]
    [OutputType([System.Collections.Generic.List[PSCustomObject]])]
    param ()
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    if (-not $script:DCOpsJsonDataCache) { return }
    $CacheCopy = Copy-DCOpsDataCache
    return ,$CacheCopy
 }