function Get-DCOpsJsonDataFile {
   [CmdletBinding()]
   [OutputType([object], [string])]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$Name,
      [switch]$ForceRefresh,
      [switch]$AsJson

   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
   $Caller = (Get-PSCallStack)[1].Command
   $MaxJsonDataCacheAge = [int](Get-DCOpsLocalSetting -Name 'maxjsondatacacheage')
   $FileName = [System.IO.Path]::GetFileNameWithoutExtension($Name)
   $DCOpsHost = (Get-DCOpsLocalSetting -Name 'dcopshost')
      
   if (-not (Get-DCOpsJsonDataFileAccess -Name $FileName -Caller $Caller -Access Read)) {
      throw "Permission denied to Json Data file $FileName"
      return
   }
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

   $Uri = "$DCOpsHost/jsondata/$($FileName).json"
   $Headers = @{
      'Accept' = 'application/json'
   }
   $Params = @{
      Uri = $Uri
      Headers = $Headers
      Method = 'Get'
      Verbose = $false
      UseBasicParsing = $true
      ErrorAction = 'SilentlyContinue'
   }
   if ($PSEdition -eq 'Core') {
      $Params['SkipCertificateCheck'] = $true
   } else {
      Disable-SslCertificateValidation
   }
   try {
      $WebResponse = Invoke-WebRequest @Params
      $StatusCode = $WebResponse.StatusCode
   } catch {
      $StatusCode = $_.Exception.Response.StatusCode.value__
   } finally {
      $ProgressPreference = $SavedProgressPreference
   }

   # if ($WebResponse.StatusCode -ne 200) {
   #    $ProgressPreference = $SavedProgressPreference
   #    return $null
   # }
   
   switch ($StatusCode) {
      200 {
         $CacheObject.RawJson = $WebResponse.Content
         $CacheObject.LastRetrieved = Get-Date
         $script:DCOpsJsonDataCache.Add($CacheObject) | Out-Null
         if ($AsJson) {
            return $CacheObject.RawJson
         } else {
            return $CacheObject.DataObject
         }
      }
      404 {
         return [string]::Empty
      }
      default { 
         return $null
      }
   }
 }