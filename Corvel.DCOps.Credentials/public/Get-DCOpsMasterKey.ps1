function Get-DCOpsMasterKey {
   [CmdletBinding()]
   [OutputType([securestring])]
   param ()

   $MasterKey = Get-DCOpsLocalSetting -Key 'dcopsmasterkey'
   if ($MasterKey) {
      $MasterKey = $MasterKey | ConvertTo-SecureString -ErrorAction SilentlyContinue
   }
   return $MasterKey
}