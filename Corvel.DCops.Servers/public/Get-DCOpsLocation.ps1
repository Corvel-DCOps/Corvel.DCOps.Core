function Get-DCOpsLocation {
   [CmdletBinding()]
   param ()

   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

   return (Get-DCOpsSharedSetting -Key 'locations' -DefaultValue $script:DCOpsLocationDefaults)
}