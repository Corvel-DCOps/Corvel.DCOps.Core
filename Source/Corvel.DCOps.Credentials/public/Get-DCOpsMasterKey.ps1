function Get-DCOpsMasterKey {
#        Get-DCOpsMasterKey
   [CmdletBinding()]
   [OutputType([securestring])]
   param ()

   if (-not ($MasterKey = Get-DCOpsLocalSetting -Key 'dcopsmasterkey' | ConvertTo-SecureString -ErrorAction SilentlyContinue)) {
      throw 'DCOps Master Key not found.'
      return
   }
   return $MasterKey
}