function New-EncryptionKey {
   [CmdletBinding()]
   param (
      [ValidateSet(128,192,256)]
      [int]$KeySize = 256,
      [switch]$AsSecureString
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
   $Length = $KeySize / 8
   $NewKey = [System.Web.Security.Membership]::GeneratePassword($Length, 0)
   if ($AsSecureString) {
      return $NewKey | ConvertTo-SecureString -AsPlainText -Force
   } else {
      return $NewKey
   }
}