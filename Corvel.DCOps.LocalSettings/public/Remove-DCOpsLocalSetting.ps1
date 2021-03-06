function Remove-DCOpsLocalSetting {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([System.Void])]
    param (
       [Parameter(Mandatory = $true)]
       [ValidateNotNullOrEmpty()]
       [Alias('Name')]
       [string]$Key
    )
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    
    $LocalSettingsHash = Import-DCOpsLocalSettings
    if ($LocalSettingsHash.ContainsKey($Key)) {
       if ($PSCmdlet.ShouldProcess($Key, "Removing setting")) {
          $LocalSettingsHash.Remove($Key)
          $LocalSettingsHash | ConvertTo-Json | Set-Content $script:LocalSettingsFile
       }
    }
 }