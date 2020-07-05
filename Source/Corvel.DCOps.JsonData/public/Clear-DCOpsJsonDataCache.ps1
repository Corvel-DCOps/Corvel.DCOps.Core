function Clear-DCopsJsonDataCache {
    [CmdletBinding()]
    param ()
    $script:DCOpsJsonDataCache = [System.Collections.Generic.List[object]]@()
 }