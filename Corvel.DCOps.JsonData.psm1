# Cache objects retrieved so we don't have to get them every time
# Age of objects in the cache controlled by LocalSetting maxjsondatacacheage
$global:DCOpsJsonDataCache = [System.Collections.Generic.List[object]]@()

function New-DCOpsJsonDataCacheObject {
   [CmdletBinding()]
   param (
      [ValidateNotNullOrEmpty()]
      [string]$Name = '',
      [ValidateNotNullOrEmpty()]
      [datetime]$LastRetrieved = 0,
      [ValidateNotNullOrEmpty()]
      [string]$RawJson
   )
   $NewObject = [PSCustomObject][ordered]@{PSTypeName = 'JsonDataCacheObject'
      Name = $Name
      LastRetrieved = $LastRetrieved
      RawJson = $RawJson
   }
   $NewObject = $NewObject | Add-Member -Name 'Age' -MemberType ScriptProperty -PassThru -Value {
      return (New-TimeSpan -Start $this.LastRetrieved).TotalSeconds
   }
   $NewObject = $NewObject | Add-Member -Name 'DataObject' -MemberType ScriptProperty -PassThru -Value {
      return ($this.RawJson | ConvertFrom-Json)
   }
   return $NewObject
}

function Get-DCOpsJsonDataFile {
   [CmdletBinding()]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$Name,
      [switch]$ForceRefresh,
      [ValidateNotNullOrEmpty()]
      [string]$DCOpsServer = (Get-DCOpsLocalSetting -Name 'dcopsserver')
   )
   $MaxJsonDataCacheAge = [int](Get-DCOpsLocalSetting -Name 'maxjsondatacacheage' -DefaultValue 3600)
   $FileName = [System.IO.Path]::GetFileNameWithoutExtension($Name)
   $CacheObject = $global:DCOpsJsonDataCache | Where-Object Name -eq $FileName
   if ($null -eq $CacheObject) {
      $CacheObject = New-DCOpsJsonDataCacheObject -Name $FileName      
   } elseif ($CacheObject.Age -lt $MaxJsonDataCacheAge -and $ForceRefresh -eq $false) {
      return $CacheObject.DataObject
   } else {
      $global:DCOpsJsonDataCache.Remove($CacheObject)
   }
   
   $SavedProgressPreference = $ProgressPreference
   $ProgressPreference = 'SilentlyContinue'

   $Uri = "$DCOpsServer/jsondata/$($FileName).json"
   $Headers = @{
      'Accept' = 'application/json'
   }
   
   try {
      $WebResponse = Invoke-WebRequest -Uri $Uri -Headers $Headers -Method Get -Verbose:$false -ErrorAction SilentlyContinue
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
   $global:DCOpsJsonDataCache.Add($CacheObject) | Out-Null
   return $CacheObject.DataObject

}

function Get-DCOpsJsonDataShare {
   [CmdletBinding()]
   param (
      [ValidateNotNullOrEmpty()]
      [string]$DCOpsServer = (Get-DCOpsLocalSetting -Name 'dcopsserver')
   )

   $URI = [uri]$DCOpsServer
   if (-not ($DnsRecords = Resolve-DnsName $URI.DnsSafeHost -Type A -ErrorAction SilentlyContinue)) { return }
   $DNSHost = $DnsRecords | Where-Object QueryType -eq 'A' | Select-Object -First 1
   if (-not ($CimSession = New-CimSession -ComputerName $DNSHost.Name -ErrorAction SilentlyContinue)) { return }
   if (-not ($SmbShare = Get-SmbShare -Name 'jsondata' -CimSession $CimSession -ErrorAction SilentlyContinue )) { return }     
   $JsonDataShare = "\\$($SmbShare.PSComputerName)\jsondata"
   if (Test-Path $JsonDataShare) {
      Write-Output $JsonDataShare
   }
   Remove-CimSession -CimSession $CimSession -ErrorAction SilentlyContinue
}

function Set-DCOpsJsonDataFile {
   [CmdletBinding(SupportsShouldProcess)]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$Name,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [object[]]$DataObject,
      [ValidateNotNullOrEmpty()]
      [string]$DCOpsServer = (Get-DCOpsLocalSetting -Name 'dcopsserver')
   )

   if (-not ($JsonDataShare = Get-DCOpsJsonDataShare -DCOpsServer $DCOpsServer)) { 
      throw "Unable to locate DCOps Host and/or Data Share"
   }
   $FileName = [System.IO.Path]::GetFileNameWithoutExtension($Name)
   $FilePath = "$JsonDataShare\$($FileName).json"
   try {
      $DataObject | ConvertTo-Json | Set-Content -LiteralPath $FilePath -ErrorAction Stop
   } catch {
      throw "Unable to create Json Data File '$($FileName).json'"
   }
}