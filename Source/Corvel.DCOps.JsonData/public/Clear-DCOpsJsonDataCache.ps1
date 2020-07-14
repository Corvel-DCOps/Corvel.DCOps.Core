function Clear-DCopsJsonDataCache {
    [CmdletBinding()]
    [OutputType([System.Void])]
    param ()
    $script:DCOpsJsonDataCache = [System.Collections.Generic.List[PSCustomObject]]@()
 }