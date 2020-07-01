<#
.SYNOPSIS
   Imports the 'sharedsettings' data file and converts it to a hash table.

.DESCRIPTION
   Imports the 'sharedsettings' data file and converts it to a hash table.
   This function is intended for internal use and is not exported.

.PARAMETER DCOpServer
The server to retreive the data from, specified as http[s]://servername:[port]. If not specified, the 'dcopserver' local setting is used.

.EXAMPLE
PS> Import-DCOpsSharedSettings
Returns a hash table containing all of the shared settings on the DCOps server

.OUTPUTS
A hash table containing the shared settings from the DCOps server.

#>
function Import-DCOpsSharedSettings {
   [CmdletBinding()]
   param (
      [ValidateNotNullOrEmpty()]
      [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
   )
   $SharedSettingsHash = @{}

   $SharedSettingsJson = Get-DCOpsJsonDataFile -Name 'sharedsettings' -DCOpServer $DCOpServer
   if ($SharedSettingsJson) {
      $SharedSettingsJson | Get-Member -MemberType NoteProperty | ForEach-Object {
         $SharedSettingsHash[$_.Name] = $SharedSettingsJson.($_.Name)
      }
   }
   return $SharedSettingsHash
}

<#
.SYNOPSIS
Retrieves a shared setting from the DCOps Server.

.DESCRIPTION
Retrieves a shared setting from the DCOps Server.
If no key is specified, all settings are retrieved. 
If the key is not found, the default value (if specified) is returned.

.PARAMETER Key
The setting to return.

.PARAMETER DefaultValue
If the key is not found, return this value

.PARAMETER DCOpServer
The server to retreive the data from, specified as http[s]://servername:[port]. If not specified, the 'dcopserver' local setting is used.

.EXAMPLE
PS> Get-DCOpsSharedSetting -Key 'smtpserver' 
smtp.corvel.com

.EXAMPLE
PS> Get-DCOpsSharedSetting
Name                           Value
----                           -----
orphanedfilespendingage        23
orphanedfilesdeleteage         30
scriptingserver                hbdcdcops02.corvel.com

.INPUTS
This cmdlet does not accept pipeline input.

.OUTPUTS
A string with the value of the specified setting or a hash table with all of the settings.

#>
function Get-DCOPsSharedSetting {
   [CmdletBinding()]
   param (
      [Parameter(Position=0)]
      [ValidateNotNullOrEmpty()]
      [Alias('Name')]
      [string]$Key,
      [Parameter(Position=1)]
      [ValidateNotNullOrEmpty()]
      [string]$DefaultValue,
      [ValidateNotNullOrEmpty()]
      [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
   )
   $SharedSettingsHash = Import-DCOpsSharedSettings -DCOpServer $DCOpServer

   if ($PSBoundParameters.ContainsKey('Name')) {
      # See if the local file had the key being looked for
      if ($SharedSettingsHash.ContainsKey($Name)) {
         return $SharedSettingsHash[$Name]
      } else {
         # If a default was supplied or we have one, return it
         if ($PSBoundParameters.ContainsKey($DefaultValue)) {
            return $DefaultValue
         } else {
            return [string]::Empty
         }
      }
   }

   # No key was specified so just return all of the settings
   return $SharedSettingsHash
}

<#
.SYNOPSIS
Adds/Updates a shared setting.

.DESCRIPTION
Adds/Updates a shared setting. The setting will be created if it does not exist.

.PARAMETER Key
The value that is being added or updated.

.PARAMETER Value
The value to set the key to.

.PARAMETER DCOpServer
The server to retreive the data from, specified as http[s]://servername:[port]. If not specified, the 'dcopserver' local setting is used.

.EXAMPLE
PS> Set-DCOpsSharedSetting -Key 'smtpserver' -Value 'mail.corvel.com'
Updates the 'smtpserver' shared setting to 'mail.corvel.com'.

.INPUTS
This cmdlet does not accept pipeline input.

.OUTPUTS
None
#>
function Set-DCOpsSharedSetting {
   [CmdletBinding(SupportsShouldProcess)]
   [OutputType([System.Void])]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [ALias('Name')]
      [string]$Key,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$Value,
      [ValidateNotNullOrEmpty()]
      [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
   )

   if (-not ($SharedSettingsHash = Import-DCOpsSharedSettings -DCOpServer $DCOpServer)) {
      throw 'Unabled to get Shared Settings'
      return
   }
   
   $SharedSettingsHash[$Name] = $Value
   if ($PSCmdlet.ShouldProcess('SharedSettings', 'Saving changes')) {
      Set-DCOpsJsonDataFile -Name 'sharedsettings' -DataObject $SharedSettingsHash -DCOpServer $DCOpServer
   }

}

<#
.SYNOPSIS
Removes a shared setting.

.DESCRIPTION
Removes the specified shared setting.

.PARAMETER Key
The shared setting to remove.

.PARAMETER DCOpServer
The server to retreive the data from, specified as http[s]://servername:[port]. If not specified, the 'dcopserver' local setting is used.

.EXAMPLE
PS> Remove-DCopsSharedSetting -Key 'foobar'
Removes the 'foobar' setting from the shared settings.

.INPUTS
This cmdlet does not accept pipeline input.

.OUTPUTS
None
#>
function Remove-DCOpsSharedSetting {
   [CmdletBinding(SupportsShouldProcess)]
   [OutputType([System.Void])]   
   param (
      [Parameter(Mandatory = $true)]
      [ValidateNotNullOrEmpty()]
      [Alias('Name')]
      [string]$Key,
      [ValidateNotNullOrEmpty()]
      [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
   ) 

   if (-not ($SharedSettingsHash = Get-DCOPsSharedSetting -DCOpServer $DCOpServer)) {
      throw 'Unable to get Shared Settings'
      return
   }
   if ($SharedSettingsHash.ContainsKey($Name)) {
      if ($PSCmdlet.ShouldProcess($Name, 'Removing setting')) {
         $SharedSettingsHash.Remove($Name) | Out-Null
         Set-DCOpsJsonDataFile -Name 'sharedsettings' -DataObject $SharedSettingsHash -DCOpServer $DCOpServer
      }
   }
}