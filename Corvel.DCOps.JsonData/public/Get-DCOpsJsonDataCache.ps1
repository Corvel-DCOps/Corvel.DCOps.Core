function Get-DCOpsJsonDataCache {
    [CmdletBinding()]
    [OutputType([System.Collections.Generic.List[PSCustomObject]])]
    param ()
    if (-not $script:DCOpsJsonDataCache) { return }
    $CacheCopy = Copy-DCOpsDataCache
    return ,$CacheCopy
 }