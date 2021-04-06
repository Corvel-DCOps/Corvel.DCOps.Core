function Import-DCOpsSharedSettings {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param (
    )
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    $SharedSettingsHash = @{}

    $SharedSettingsJson = Get-DCOpsJsonDataFile -Name 'sharedsettings'
    if ($SharedSettingsJson) {
       $SharedSettingsJson | Get-Member -MemberType NoteProperty | ForEach-Object {
          $SharedSettingsHash[$_.Name] = $SharedSettingsJson.($_.Name)
       }
    }
    return $SharedSettingsHash
 }