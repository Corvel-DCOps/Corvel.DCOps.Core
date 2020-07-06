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