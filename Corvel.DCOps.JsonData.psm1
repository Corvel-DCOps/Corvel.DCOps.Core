# Cache objects retrieved so we don't have to get them every time
# Age of objects in the cache controlled by LocalSetting maxjsondatacacheage
$script:DCOpsJsonDataCache = [System.Collections.Generic.List[object]]@()

<#
.SYNOPSIS
Creates a new PSCustomObject for caching Json data retrieved from the DCOps Server
Only used internally, not exported.
#>
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
   # Calculate the age of the object
   $NewObject = $NewObject | Add-Member -Name 'Age' -MemberType ScriptProperty -PassThru -Value {
      return (New-TimeSpan -Start $this.LastRetrieved).TotalSeconds
   }
   # Return the raw json converted to a PSCustomObject
   $NewObject = $NewObject | Add-Member -Name 'DataObject' -MemberType ScriptProperty -PassThru -Value {
      return ($this.RawJson | ConvertFrom-Json)
   }
   return $NewObject
}

<#
.SYNOPSIS
Retrieve a Json data file from the DCOps Server

.DESCRIPTION
Get-DCOpsJsonDataFile retrieves the specified json data file from the DCOps Server and returns either
the converted object (using ConvertFrom-Json) or the raw json (with the AsJson flag).
The Name of the data file can be specified with or without the json extension.

If the DCOpServer is not specified, the value is retrieved from local settings.

When a data file is retrieved, it is added to a local cache to speed up subsequent opertations. If the ForceRefresh 
flag is set or if the cached data has expired, the cache is ignored and the data is retrieved directly from the server.
The maximum age of an object in the cache is controled by the 'maxjsondatacacheage' local setting.

Json data files are stored in the 'jsondata' virtual directory on the DCOps Server.
.PARAMETER

.EXAMPLE
PS> Get-DCOpsJsonDataFile -Name 'sharedsettings'
Retrieves the 'sharedsettings.json' file from the DCOps server and returns the contents as a PSCustomObject.

.EXAMPLE
PS> Get-DCopsJsonDataFile -Name 'sharedsettings' -AsJson
Retrieves the 'sharedsettings.json' file from the DCOps server and returns the raw json.

.INPUTS
This cmdlet does not accept pipeline input.

.OUTPUTS
Either a PSCustom object created from converting the retrieved Json or the raw json data.

.PARAMETER Name
The name of the data file to retrieve. This can be specified with or without the an extension.
If an extension is specified, the extension is removed and .json is appended.

.PARAMETER ForceRefresh
Do not use the cached data (if present) and retrieve the data from the server.

.PARAMETER DCOpServer
The server to retreive the data from, specified as http[s]://servername:[port]. If not specified, the 'dcopserver' local setting is used.
The server specified must have the data files in '/jsondata' and the data files must have a .json extension.

.PARAMETER AsJson
Instead of returning a PSCustomObject, return the raw json data as a string.
This is useful if custom processing needs to happen with the json data.
#>
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
   $script:DCOpsJsonDataCache.Add($CacheObject) | Out-Null
   if ($AsJson) {
      return $CacheObject.RawJson
   } else {
      return $CacheObject.DataObject
   }

}

<#
.SYNOPSIS
Returns the UNC path of the Json Data folder on the DCOps Server

.DESCRIPTION
This function is primarily intended for internal use and is not exported.

#>
function Get-DCOpsJsonDataShare {
   [CmdletBinding()]
   param (
      [ValidateNotNullOrEmpty()]
      [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
   )

   # First we convert the server string (which is specified as http[s]://servername:[port])
   # to a URI object. This is easier than parsing the string out to get the host name.
   # We then do a DNS query to get the host name of the server. This handles the case 
   # where the server name is a CNAME record. 
   # We then open a Cim session and look for a shared called 'jsondata'.
   # If it is found, we return the full UNC path to the jsondata folder. 
   $URI = [uri]$DCOpServer
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

<#
.SYNOPSIS
Saves/Creates a json data file on the DCOps server.

.DESCRIPTION
This cmdlet takes an object, converts it to Json (with ConvertTo-Json) and writes it to the DCOps server.
If the file exists on the server, a backup is created (.bak).
.PARAMETER Name
The name of the json data file. If an extension is specified, it is removed and 'json' is appended.
The file does not have to exist on the server, this cmdlet can be used to create new files.

.PARAMETER InputObject
The object to save to the server.
The object will be converted to Json using ConvertTo-Json

.PARAMETER DCOpServer
The server to retreive the data from, specified as http[s]://servername:[port]. If not specified, the 'dcopserver' local setting is used.

.EXAMPLE
PS> Set-DCOpsJsonDataFile -Name 'sharedsettings' -InputObject $SharedSettings
Saves the $SharedSettings as json to 'sharedsettings.json' on the DCOps server.

.INPUTS
This cmdlet does not accept pipeline input.

.OUTPUTS
None

#>
function Set-DCOpsJsonDataFile {
   [CmdletBinding(SupportsShouldProcess)]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$Name,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [Alias('DataObject')]
      [object[]]$InputObject,
      [ValidateNotNullOrEmpty()]
      [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
   )

   if (-not ($JsonDataShare = Get-DCOpsJsonDataShare -DCOpServer $DCOpServer)) { 
      throw "Unable to locate DCOps Host and/or Data Share"
   }
   $FileName = [System.IO.Path]::GetFileNameWithoutExtension($Name)
   $FilePath = "$JsonDataShare\$($FileName).json"
   $BackupFilePath = "$JsonDataShare\$($FileName).bak"
   try {
      if ($PSCmdlet.ShouldProcess($FileName, 'Saving Json data file')) {
         if (Test-Path $FilePath) {
            Copy-Item -LiteralPath $FilePath -Destination $BackupFilePath -Force
         }
         $InputObject | ConvertTo-Json | Set-Content -LiteralPath $FilePath -ErrorAction Stop
      }
   } catch {
      throw "Unable to create Json Data File '$($FileName).json'"
   }
   if ($CacheObject = $script:DCOpsJsonDataCache | Where-Object Name -eq $FileName) {
      $script:DCOpsJsonDataCache.Remove($CacheObject) | Out-Null
   }
}

<#
.SYNOPSIS
Displays the current contents of the data cache.

.DESCRIPTION
Displays the current contents of the json data cache.

.EXAMPLE
PS> Get-DCOpsJsonDataCache
Name          : sharedsettings
LastRetrieved : 7/1/2020 2:20:15 PM
RawJson       : <Json String>
Age           : 7.1273661
DataObject    : <PSCustomObject>

.INPUTS
This cmdlet does not accept pipeline input

.OUTPUTS
The current contents of the json data cache.

#>
function Get-DCOpsJsonDataCache {
   [CmdletBinding()]
   param ()
   if (-not $script:DCOpsJsonDataCache) { return }
   $script:DCOpsJsonDataCache
}

<#
.SYNOPSIS
Clears the contents of the cache.

.DESCRIPTION
Clears the contents of the cache

.EXAMPLE
PS> Clear-DCOpsJsonDataCache
After calling the cmdlet, the cache is cleared.

.INPUTS
This cmdlet does not accept pipeline input.

.OUTPUTS
NONE
#>
function Clear-DCopsJsonDataCache {
   [CmdletBinding()]
   param ()
   $script:DCOpsJsonDataCache = [System.Collections.Generic.List[object]]@()
}