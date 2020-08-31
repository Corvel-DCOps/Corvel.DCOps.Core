function Get-DCOpsMasterKey {
   [CmdletBinding()]
   [OutputType([securestring])]
   param ()

   $MasterKey = Get-DCOpsLocalSetting -Key 'dcopsmasterkey'
   if ($MasterKey) {
      $MasterKey = $MasterKey | ConvertTo-SecureString -ErrorAction SilentlyContinue
   }
   # if (-not ($MasterKey = Get-DCOpsLocalSetting -Key 'dcopsmasterkey' | ConvertTo-SecureString -ErrorAction SilentlyContinue)) {
   #    throw 'DCOps Master Key not found.'
   #    return
   # }
   return $MasterKey
}