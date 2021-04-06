function New-EncryptionKey {
   [CmdletBinding()]
   param (
      [ValidateSet(128,192,256)]
      [int]$KeySize = 256,
      [switch]$AsSecureString
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
   $Length = $KeySize / 8

   $Symbols = '!@#$%^&*'.ToCharArray()
   $CharacterList = 'a'..'z' + 'A'..'Z' + '0'..'9' + $Symbols

   do {
      $NewKey = -join (0..$Length | ForEach-Object { $CharacterList | Get-Random })
      [int]$HasLowerChar = $NewKey -cmatch '[a-z]'
      [int]$HasUpperChar = $NewKey -cmatch '[A-Z]'
      [int]$HasDigit = $NewKey -match '[0-9]'
      [int]$HasSymbol = $NewKey.IndexOfAny($Symbols) -ne -1
   } until (($HasLowerChar + $HasUpperChar + $HasDigit + $HasSymbol) -ge 4)
   
   if ($AsSecureString) {
      return $NewKey | ConvertTo-SecureString -AsPlainText -Force
   } else {
      return $NewKey
   }
}