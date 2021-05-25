function Get-DCOpsEnvironment {
   [CmdletBinding()]
   param ()

   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

   return (Get-DCOpsSharedSetting -Key 'environments' -DefaultValue $script:DCOpsEnvironmentDefaults)
}