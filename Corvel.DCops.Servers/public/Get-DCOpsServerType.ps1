function Get-DCOpsServerType {
   [CmdletBinding()]
   param ()

   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

   return (Get-DCopsSharedSetting -Key 'servertypes' -DefaultValue $script:DCOpsServerTypeDefaults)
}