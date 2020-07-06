function Get-DCOpsJsonDataFile {
    [CmdletBinding()]
    param (
       [Parameter(Mandatory=$true)]
       [ValidateNotNullOrEmpty()]
       [string]$Name,
       [switch]$ForceRefresh,
       [ValidateNotNullOrEmpty()]
       [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver'),
       [switch]$AsJson

    )
    $MaxJsonDataCacheAge = [int](Get-DCOpsLocalSetting -Name 'maxjsondatacacheage')
    $FileName = [System.IO.Path]::GetFileNameWithoutExtension($Name)
    $CacheObject = $script:DCOpsJsonDataCache | Where-Object Name -eq $FileName
    if ($null -eq $CacheObject) {
       $CacheObject = New-DCOpsJsonDataCacheObject -Name $FileName
    } elseif ($CacheObject.Age -lt $MaxJsonDataCacheAge -and $ForceRefresh -eq $false) {
       if ($AsJson) {
          return $CacheObject.RawJson
       } else {
          return $CacheObject.DataObject
       }
    } else {
       $script:DCOpsJsonDataCache.Remove($CacheObject) | Out-Null
    }

    $SavedProgressPreference = $ProgressPreference
    $ProgressPreference = 'SilentlyContinue'

    $Uri = "$DCOpServer/jsondata/$($FileName).json"
    $Headers = @{
       'Accept' = 'application/json'
    }

    try {
       $WebResponse = Invoke-WebRequest -Uri $Uri -Headers $Headers -Method Get -Verbose:$false -UseBasicParsing -ErrorAction SilentlyContinue
    } catch {
       return $null
    } finally {
       $ProgressPreference = $SavedProgressPreference
    }

    if ($WebResponse.StatusCode -ne 200) {
       $ProgressPreference = $SavedProgressPreference
       return $null
    }

    $CacheObject.RawJson = $WebResponse.Content
    $CacheObject.LastRetrieved = Get-Date
    $script:DCOpsJsonDataCache.Add($CacheObject) | Out-Null
    if ($AsJson) {
       return $CacheObject.RawJson
    } else {
       return $CacheObject.DataObject
    }

 }