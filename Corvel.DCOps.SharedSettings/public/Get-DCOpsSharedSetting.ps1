function Get-DCOPsSharedSetting {
    [CmdletBinding()]
    [OutputType([hashtable], [string])]
    param (
       [Parameter(Position=0)]
       [ValidateNotNullOrEmpty()]
       [Alias('Name')]
       [string]$Key,
       [Parameter(Position=1)]
       [ValidateNotNullOrEmpty()]
       [string]$DefaultValue,
       [ValidateNotNullOrEmpty()]
       [string]$DCOpsHost = (Get-DCOpsLocalSetting -Name 'dcopshost')
    )
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    $SharedSettingsHash = Import-DCOpsSharedSettings -DCOpsHost $DCOpsHost

    if ($PSBoundParameters.ContainsKey('Key')) {
       # See if the local file had the key being looked for
       if ($SharedSettingsHash.ContainsKey($Key)) {
          return $SharedSettingsHash[$Key]
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