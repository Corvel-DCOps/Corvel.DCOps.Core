function Clear-DCOpsJsonDataCache {
    [CmdletBinding()]
    [OutputType([System.Void])]
    param ()
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    $script:DCOpsJsonDataCache = [System.Collections.Generic.List[PSCustomObject]]@()
 }