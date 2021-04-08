function Set-DCOpsAlias {
	[CmdletBinding(SupportsShouldProcess)]
	param (
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[string]$Name,
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[string]$Alias
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	if (-not($DCOpsAlias = Import-DCopsAliasFile)) { return }
	
	$Result = $DCOpsAlias | Where-Object Name -eq $Name
	if ($Result) {
		$DCOpsAlias.Remove($Result) | Out-Null
	}
	$NewAlias = [pscustomobject][ordered]@{Name = $Name; Alias = $Alias }
	if ($PSCmdlet.ShouldProcess('Updating Alias')) {
		$DCOpsAlias.Add($NewAlias) | Out-Null
		Set-DCOpsJsonDataFile -Name 'alias' -InputObject $DCOpsAlias
	}
	return $NewAlias
}