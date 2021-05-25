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
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    
   $LocalSettingsHash = Import-DCOpsLocalSettings

   # Protect the master key
   $Caller = (Get-PSCallStack)[1].Command
   if ($Caller -ne 'Set-DCOpsMasterKey' -and $Key -eq 'dcopsmasterkey') {
      Write-Warning "$Key is a system protected value"
      return 
   }


   if ($PSCmdlet.ShouldProcess($Key, 'Setting value')) {
      $LocalSettingsHash[$Key] = $Value
      $LocalSettingsPath = Split-Path $script:LocalSettingsFile
      if (-not(Test-Path $LocalSettingsPath)) {
         New-Item -Path $LocalSettingsPath -ItemType Directory -Force | Out-Null
      }
      $LocalSettingsHash | ConvertTo-Json | Set-Content $script:LocalSettingsFile
   }
 }