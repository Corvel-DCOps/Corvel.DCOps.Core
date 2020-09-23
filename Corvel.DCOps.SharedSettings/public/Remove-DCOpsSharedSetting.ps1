function Remove-DCOpsSharedSetting {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([System.Void])]
    param (
       [Parameter(Mandatory = $true)]
       [ValidateNotNullOrEmpty()]
       [Alias('Name')]
       [string]$Key,
       [ValidateNotNullOrEmpty()]
       [string]$DCOpsHost = (Get-DCOpsLocalSetting -Name 'dcopshost')
    )
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    if (-not ($SharedSettingsHash = Get-DCOPsSharedSetting -DCOpsHost $DCOpsHost)) {
       throw 'Unable to get Shared Settings'
       return
    }
    if ($SharedSettingsHash.ContainsKey($Key)) {
       if ($PSCmdlet.ShouldProcess($Key, 'Removing setting')) {
          $SharedSettingsHash.Remove($Key) | Out-Null
          Set-DCOpsJsonDataFile -Name 'sharedsettings' -DataObject $SharedSettingsHash -DCOpsHost $DCOpsHost
       }
    }
 }