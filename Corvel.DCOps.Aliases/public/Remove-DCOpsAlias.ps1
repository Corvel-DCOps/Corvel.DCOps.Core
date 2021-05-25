function Remove-DCOpsAlias {
	[CmdletBinding(SupportsShouldProcess)]
	param (
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[string]$Name
	)

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	if (-not ($DCOpsAlias = Import-DCopsAliasFile)) { return }

	$Result = $DCopsAlias | Where-Object Name -eq $Name
	if ($Result) {
		if ($PSCmdlet.ShouldProcess($Name, 'Remove alias')) {
			$DCOpsAlias.Remove($Result) | Out-Null
			Set-DCOpsJsonDataFile -Name 'alias' -InputObject $DCOpsAlias
		}
	}
}