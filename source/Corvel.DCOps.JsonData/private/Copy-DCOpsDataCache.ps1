function Copy-DCOpsDataCache {
   [CmdletBinding()]
   [OutputType([System.Collections.Generic.List[PSCustomObject]])]
   param ()
   $CacheCopy = [System.Collections.Generic.List[PSCustomObject]]@()
   foreach ($CacheObject in $script:DCOpsJsonDataCache) {
      $CacheParams = @{
         Name = $CacheObject.Name
         LastRetrieved = $CacheObject.LastRetrieved
         RawJson = $CacheObject.RawJson
      }
      $NewObject = New-DCOpsJsonDataCacheObject @CacheParams
      $CacheCopy.Add($NewObject) | Out-Null
   }
   return ,$CacheCopy
}