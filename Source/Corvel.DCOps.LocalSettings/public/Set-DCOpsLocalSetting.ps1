function Set-DCOpsLocalSetting {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([System.Void])]
    param (
       [Parameter(Mandatory=$true)]
       [ValidateNotNullOrEmpty()]
       [Alias('Name')]
       [string]$Key,
       [Parameter(Mandatory=$true)]
       [ValidateNotNullOrEmpty()]
       [string]$Value
    )
    $LocalSettingsHash = Import-DCOpsLocalSettings
    if ($PSCmdlet.ShouldProcess($Key, 'Setting value')) {
       $LocalSettingsHash[$Key] = $Value
       $LocalSettingsPath = Split-Path $script:LocalSettingsFile
       if (-not(Test-Path $LocalSettingsPath)) {
          New-Item -Path $LocalSettingsPath -ItemType Directory -Force | Out-Null
       }
       $LocalSettingsHash | ConvertTo-Json | Set-Content $script:LocalSettingsFile
    }
 }