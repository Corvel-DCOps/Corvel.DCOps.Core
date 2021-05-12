function Get-DCOpsLocalSetting {
    [CmdletBinding()]
    [OutputType([string])]
    param (
       [Parameter(Position=0)]
       [ValidateNotNullOrEmpty()]
       [Alias('Name')]
       [string]$Key,
       [Parameter(Position=1)]
       [ValidateNotNullOrEmpty()]
       [string]$DefaultValue
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
   
   $LocalSettingsHash = Import-DCOpsLocalSettings

   # Protect the Master Key
   $Caller = (Get-PSCallStack)[1].Command
   if ($Caller -ne 'Get-DCOpsMasterKey') {
      if ($Key -eq 'dcopsmasterkey') {
         Write-Warning "$Key is a system protected value"
         return
      } 
      if ($LocalSettingsHash.ContainsKey('dcopsmasterkey')) { $LocalSettingsHash.Remove('dcopsmasterkey') }
   }

   if ($PSBoundParameters.ContainsKey('Key')) {
       # See if the local file had the key being looked for
       if ($LocalSettingsHash.ContainsKey($Key)) {
          return $LocalSettingsHash[$Key]
       } else {
          # If a default was supplied or we have one, return it
          if ($PSBoundParameters.ContainsKey('DefaultValue')) {
             return $DefaultValue
          } elseif ($script:DefaultValues.ContainsKey($Key)) {
             return $script:DefaultValues[$Key]
          } else {
             return [string]::Empty
          }
       }
    }

    # No key was specified so just return all of the settings
    return $LocalSettingsHash
 }