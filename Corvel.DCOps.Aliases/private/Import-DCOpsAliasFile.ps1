function Import-DCOpsAliasFile {
	[CmdletBinding()]
	[OutputType([System.Collections.Generic.List[PSCustomObject]])]
	param ()

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	$DCOpsAlias = [System.Collections.Generic.List[PSCustomObject]]@()
	$Aliases = Get-DCOpsJsonDataFile -Name 'alias'

	if ($null -eq $Aliases) {
      throw 'Unable to load servers file.'
      return
   }
	foreach ($Alias in $Aliases) {
		$NewAlias = [pscustomobject][ordered]@{Name = $Alias.Name; Alias = $Alias.Alias }
		$DCOpsAlias.Add($NewAlias)
	}
	return ,$DCOpsAlias
}