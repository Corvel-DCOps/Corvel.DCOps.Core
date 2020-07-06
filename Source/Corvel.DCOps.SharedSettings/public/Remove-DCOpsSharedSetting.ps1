function Remove-DCOpsSharedSetting {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([System.Void])]
    param (
       [Parameter(Mandatory = $true)]
       [ValidateNotNullOrEmpty()]
       [Alias('Name')]
       [string]$Key,
       [ValidateNotNullOrEmpty()]
       [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
    )

    if (-not ($SharedSettingsHash = Get-DCOPsSharedSetting -DCOpServer $DCOpServer)) {
       throw 'Unable to get Shared Settings'
       return
    }
    if ($SharedSettingsHash.ContainsKey($Key)) {
       if ($PSCmdlet.ShouldProcess($Key, 'Removing setting')) {
          $SharedSettingsHash.Remove($Key) | Out-Null
          Set-DCOpsJsonDataFile -Name 'sharedsettings' -DataObject $SharedSettingsHash -DCOpServer $DCOpServer
       }
    }
 }