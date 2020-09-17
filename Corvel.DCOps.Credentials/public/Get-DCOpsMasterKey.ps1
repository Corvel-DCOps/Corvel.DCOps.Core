function Get-DCOpsMasterKey {
   [CmdletBinding()]
   [OutputType([securestring])]
   param ()
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
   $MasterKey = Get-DCOpsLocalSetting -Key 'dcopsmasterkey'
   if ($MasterKey) {
      $MasterKey = $MasterKey | ConvertTo-SecureString -ErrorAction SilentlyContinue
   }
   return $MasterKey
}