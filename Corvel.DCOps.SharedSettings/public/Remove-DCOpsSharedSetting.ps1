function Remove-DCOpsSharedSetting {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([System.Void])]
    param (
       [Parameter(Mandatory = $true)]
       [ValidateNotNullOrEmpty()]
       [Alias('Name')]
       [string]$Key
    )
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    if (-not ($SharedSettingsHash = Get-DCOPsSharedSetting)) {
       throw 'Unable to get Shared Settings'
       return
    }
    if ($SharedSettingsHash.ContainsKey($Key)) {
       if ($PSCmdlet.ShouldProcess($Key, 'Removing setting')) {
          $SharedSettingsHash.Remove($Key) | Out-Null
          Set-DCOpsJsonDataFile -Name 'sharedsettings' -DataObject $SharedSettingsHash 
       }
    }
 }