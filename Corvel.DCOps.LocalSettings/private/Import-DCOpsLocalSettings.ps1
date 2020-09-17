function Import-DCOpsLocalSettings {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param()
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
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