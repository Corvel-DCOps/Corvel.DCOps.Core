function Set-DCOpsHost {
   [CmdletBinding()]
   [OutputType([System.Collections.Generic.List[PSCustomObject]])]
   param ()
   
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
}