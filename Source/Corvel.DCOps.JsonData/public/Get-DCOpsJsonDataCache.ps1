function Get-DCOpsJsonDataCache {
    [CmdletBinding()]
    param ()
    if (-not $script:DCOpsJsonDataCache) { return }
    $script:DCOpsJsonDataCache
 }