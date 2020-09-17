function Set-DCOpsMasterKey {
   [CmdletBinding(SupportsShouldProcess, ConfirmImpact="High")]
   [OutputType([System.Void])]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateScript({
         ($_.Length -eq 16 -or $_.Length -eq 24 -or $_.Length -eq 32)
      })]
      [string]$Key,
      [switch]$Force
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
   
   if ($Force -and -not $Confirm) {
      $ConfirmPreference = 'None'
   }
   $ExistingKey = Get-DCOpsMasterKey
   $NewKey = $Key | ConvertTo-SecureString -AsPlainText -Force 

<#     if (-not ($ExistingKey = Get-DCOpsMasterKey)) {
       Write-Warning 'Existing DCOps Master Key not found.'
    }
    if (-not $Force -and $ExistingKey) {
       $ConfirmExistingKey = Read-Host "Enter the existing master key" -AsSecureString
       if (($ExistingKey | ConvertTo-PlainString) -ne ($ConfirmExistingKey | ConvertTo-PlainString)) {
          Write-Warning 'Invalid Master Key entered.'
          return
       }
    }
    $NewKey = Read-Host "Enter the new master key" -AsSecureString
    $ConfirmNewKey = Read-Host "Confirm the new master key" -AsSecureString
    if (($NewKey | ConvertTo-PlainString) -ne ($ConfirmNewKey | ConvertTo-PlainString)) {
       Write-Warning 'Master Keys do not match'
       return
    }
 #>
    if ($PSCmdlet.ShouldProcess('DCOps Master Key')) {
       # Whenever we change the master key, we want to keep the old one just in case
       try {
          if ($ExistingKey) {
             $ExistingKey | Select-Object @{N='ChangeDate'; E={Get-Date}}, @{N='Key'; E={$_ | ConvertFrom-SecureString}} |
                Export-Csv -Path $script:MasterKeyHistory -NoTypeInformation -Append
          }
          Set-DCOpsLocalSetting -Key 'dcopsmasterkey' -Value ($NewKey | ConvertFrom-SecureString)
       } catch {
          $_
          throw 'Error changing DCOps Master Key'
       }
    }
 }