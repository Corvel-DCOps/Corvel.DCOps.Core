function Import-DCOpsSharedSettings {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param (
       [ValidateNotNullOrEmpty()]
       [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
    )
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    $SharedSettingsHash = @{}

    $SharedSettingsJson = Get-DCOpsJsonDataFile -Name 'sharedsettings' -DCOpServer $DCOpServer
    if ($SharedSettingsJson) {
       $SharedSettingsJson | Get-Member -MemberType NoteProperty | ForEach-Object {
          $SharedSettingsHash[$_.Name] = $SharedSettingsJson.($_.Name)
       }
    }
    return $SharedSettingsHash
 }