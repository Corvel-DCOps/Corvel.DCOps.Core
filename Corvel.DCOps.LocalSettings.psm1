# HashTable containing the default values if a saved value isn't found.
# Not all possible values are here.
$script:DefaultValues = @{
   dcopserver = 'https://dcops.corvel.com'
   dcopdbserver = 'hbdcdcops02'
   maxjsondatacacheage = '900'
}
$script:LocalSettingsFile = "$env:APPDATA\Corvel.DCOps\localsettings.json"

<#
.SYNOPSIS
Imports the local settings file from %APPDATA%\Corvel.DCOps\localsettings.json.

.DESCRIPTION
Imports the local settings file from %APPDATA%\Corvel.DCOps\localsettings.json and converts
the contents to a hashtable.
Primarily for internal used.

.EXAMPLE
PS> Import-DCOpsLocalSettings
Name                           Value
----                           -----
dcopserver                    https://dcops.corvel.com

.INPUTS
None. This cmdlet does not accept any parameters

.OUTPUTS
A hashtable containg the name and value of all settings in the local settings file.

.NOTES

.LINK
Get-DCOpsLocalSetting
Set-DCOpsLocalSetting
Remove-DCOpsLocalSetting
#>
function Import-DCOpsLocalSettings {
   [CmdletBinding()]
   [OutputType([hashtable])]
   param()
   $LocalSettingsHash = @{}
   # If we have a local file, load it and convert to a hashtable
   if (Test-Path $script:LocalSettingsFile) {
      $LocalSettingsJson = Get-Content $script:LocalSettingsFile | ConvertFrom-Json
      $LocalSettingsJson | Get-Member -MemberType NoteProperty | ForEach-Object {
         $LocalSettingsHash[$_.Name] = $LocalSettingsJson.($_.Name)
      }
   }
   return $LocalSettingsHash
}

<#
.SYNOPSIS
This cmdlet returns the value of a setting from the local settings file.

.DESCRIPTION
This cmdlet returns the value of a setting from the local settings file. 
The local settings file is a collection Key-Value pairs.
If no name (key) is specified, all values in the file are returned as a hashtable.
If a specified name (key) is not found in the file, a default value (if one exists or is specified) is returned.
The local settings file is stored at %APPDATA%\Corvel.DCOps\localsettings.json.

.PARAMETER Name
The name of the setting (key) to return.

.PARAMETER DefaultValue
A default value to return if the name (key) is not found.
Some settings have a global default. Use Get-DCOPsLocalSettingsDefaults to view them.

.EXAMPLE
PS> Get-DCOpsLocalSetting
Returns all settings in the local settings file as a hashtable

.EXAMPLE
PS> Get-DCOpsLocalSetting -Name 'dcopserver'
Returns the string value stored for the dcopserver key.

.EXAMPLE
PS> Get-DCOpsLocalSetting -Name 'smtpserver' -DefaultValue 'smtp.corvel.com'
Returns the string value for 'smtpserver' from the local settings file if it exists or 'smtp.corvel.com'

.INPUTS
This cmdlet does not accept pipeline input.

.OUTPUTS
The string value or default value for the specified name (key) or a hashtable containing all of the Key-Value pairs in the local settings file.

.LINK
Set-DCOpsLocalSetting
Remove-DCOpsLocalSetting
Get-DCOpsLocalSettingsDefaults

#>
function Get-DCOpsLocalSetting {
   [CmdletBinding()]
   param (
      [Parameter(Position=0)]
      [ValidateNotNullOrEmpty()]
      [Alias('Key')]
      [string]$Name,
      [Parameter(Position=1)]
      [ValidateNotNullOrEmpty()]
      [string]$DefaultValue
   )
   $LocalSettingsHash = Import-DCOpsLocalSettings

   if ($PSBoundParameters.ContainsKey('Name')) {
      # See if the local file had the key being looked for
      if ($LocalSettingsHash.ContainsKey($Name)) {
         return $LocalSettingsHash[$Name]
      } else {
         # If a default was supplied or we have one, return it
         if ($PSBoundParameters.ContainsKey($DefaultValue)) {
            return $DefaultValue
         } elseif ($script:DefaultValues.ContainsKey($Name)) {
            return $script:DefaultValues[$Name]
         } else {
            return [string]::Empty
         }
      }
   }

   # No key was specified so just return all of the settings
   return $LocalSettingsHash
}

<#
.SYNOPSIS
Sets the value of the specified name (key) in the local settings file.

.DESCRIPTION
Sets the value of the specified name (key) in the local settings file. If the name (key) does not exist, the Key-Value pair is created.
The local settings file is stored at %APPDATA%\Corvel.DCOps\localsettings.json.

.PARAMETER Name
The name of the setting to update or create.

.PARAMETER Value
The value of the name (key).

.EXAMPLE
PS> Set-DCOpsLocalSetting -Name 'smtpserver' -Value 'smtp.corvel.com'
Updates or creates a setting with name of 'smtpserver' and the value 'smtp.corvel.com'

.INPUTS
This cmdlet does not accept pipeline input.

.OUTPUTS
None

.LINK
Get-DCOpsLocalSetting
Remove-DCOpsLocalSetting
Get-DCOpsLocalSettingsDefaults
#>
function Set-DCOpsLocalSetting {
   [CmdletBinding(SupportsShouldProcess)]
   [OutputType([System.Void])]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$Name,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$Value
   )
   $LocalSettingsHash = Import-DCOpsLocalSettings
   if ($PSCmdlet.ShouldProcess($Name, 'Setting value')) {
      $LocalSettingsHash[$Name] = $Value
      $LocalSettingsHash | ConvertTo-Json | Set-Content $script:LocalSettingsFile 
   }
}

<#
.SYNOPSIS
Removes an item from the local settings file.

.DESCRIPTION
Removes the specified name (key) from the local settings file if it exists.
The local settings file is stored at %APPDATA%\Corvel.DCOps\localsettings.json.

.PARAMETER Name
The name (key) of the setting to remove.

.EXAMPLE
PS> Remove-DCOpsLocalSetting -Name 'smtpserver'
Removes the 'smtpserver' Key-Value from the local settings file.

.INPUTS
This cmdlet does not accept pipeline input.

.OUTPUTS
None

.LINK
Get-DCOpsLocalSetting
Set-DCOpsLOcalSetting
Get-DCOpsLocalSettingsDefaults
#>
function Remove-DCOpsLocalSetting {
   [CmdletBinding(SupportsShouldProcess)]
   [OutputType([System.Void])]   
   param (
      [Parameter(Mandatory = $true)]
      [ValidateNotNullOrEmpty()]
      [Alias('Key')]
      [string]$Name
   ) 
   $LocalSettingsHash = Import-DCOpsLocalSettings
   if ($LocalSettingsHash.ContainsKey($Name)) {
      if ($PSCmdlet.ShouldProcess($Name, "Removing setting")) {
         $LocalSettingsHash.Remove($Name)
         $LocalSettingsHash | ConvertTo-Json | Set-Content $script:LocalSettingsFile 
      }
   }  
}

<#
.SYNOPSIS
Returns the system defined default values.

.DESCRIPTION
This cmdlet returns a hashtable containing the Key-Value pairs for the system defined (hard coded) default values.
The local settings file is stored at %APPDATA%\Corvel.DCOps\localsettings.json.

.EXAMPLE
PS> Get-DCOpsLocalSettingsDefaults
Name                           Value
----                           -----
dcopserver                    https://dcops.corvel.com

.INPUTS
None

.OUTPUTS
None

.LINK
Get-DCOpsLocalSetting
Set-DCOpsLocalSetting
Remove-DCOpsLocalSetting
#>
function Get-DCOpsLocalSettingsDefaults {
   [CmdletBinding()]
   param ()
   return $script:DefaultValues
}