function Import-DCOpsSharedSettings {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param (
       [ValidateNotNullOrEmpty()]
       [string]$DCOpsHost = (Get-DCOpsLocalSetting -Name 'dcopshost')
    )
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    $SharedSettingsHash = @{}

    $SharedSettingsJson = Get-DCOpsJsonDataFile -Name 'sharedsettings' -DCOpsHost $DCOpsHost
    if ($SharedSettingsJson) {
       $SharedSettingsJson | Get-Member -MemberType NoteProperty | ForEach-Object {
          $SharedSettingsHash[$_.Name] = $SharedSettingsJson.($_.Name)
       }
    }
    return $SharedSettingsHash
 }