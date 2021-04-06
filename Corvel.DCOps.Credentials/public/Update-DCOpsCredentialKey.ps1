function Update-DCOpsCredentialKey {
   [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
   param (
      [ValidateNotNullOrEmpty()]
      [securestring]$OldKey = (Get-DCOpsMasterKey),
      [ValidateNotNullOrEmpty()]
      [securestring]$NewKey = (New-EncryptionKey -AsSecureString),
      [switch]$SaveKey,
      [switch]$SkipBackup,
      [switch]$Force
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

   $CredentialStore = [System.Collections.Generic.List[PSCustomObject]]@()
   if ($Force -and -not $Confirm) {
      $ConfirmPreference = 'None'
   }

   $Credentials = Get-DCOpsJsonDataFile -Name 'dcopscredentials'
   foreach ($Credential in $Credentials) {
      $Params = @{
         HostName = $Credential.hostname
         UserName = $Credential.username
         Password = $Credential.encryptedpassword | ConvertTo-SecureString -Key ($OldKey | ConvertTo-PlainString | ConvertTo-ByteArray) | ConvertTo-PlainString
         Description = $Credential.description
         SecureKey = $NewKey
      }
      $NewCredential = New-DCOpsCredentialObject @Params
      if (-not $NewCredential) {
         throw 'Unable to create new credential object.'
      }
      $CredentialStore.Add($NewCredential)      
   }
   if ($PSCmdlet.ShouldProcess('Credential Store', 'Changing Encryption Key')) {      
      if (-not $SkipBackup) {
         try {
            $BackupFile = Join-Path "$env:APPDATA\Corvel.DCOps"  ("dcopscredentials-{0}.json" -f (Get-date -Format "yyyyMMdd-hhmm"))
            New-Item -Path $BackupFile -ItemType File -Force -Confirm:$false | Out-Null
            $Credentials | ConvertTo-Json | Set-Content -Path $BackupFile -Force -Confirm:$false
         } catch {
            throw 'Unable to create backup file.'
         }
      } 
      try {
         Export-DCOpsCredentialFile -InputObject $CredentialStore -Confirm:$false
      } catch {
         throw 'Unable to export new credential file.'
      }
      if ($SaveKey) {
         Set-DCOpsMasterKey -Key ($NewKey | ConvertTo-PlainString) -Confirm:$false
      }
   }

}