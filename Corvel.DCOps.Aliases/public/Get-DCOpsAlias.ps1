function Get-DCOpsAlias {
	[CmdletBinding()]
	param (
		[ValidateNotNullOrEmpty()]
		[Parameter(ValueFromPipeline)]
		[string[]]$Name
	)
	begin {
		Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

		if (-not ($DCOpsAlias = Import-DCOpsAliasFile)) { return }
	}
	process {
		if ($PSBoundParameters.ContainsKey('Name')) {
			foreach ($term in $Name) {
				$Results = $DCOpsAlias | Where-Object Name -EQ $Name
				if ($Results) {
					Write-Output $Results.Alias
				} else {
					Write-Output $Name
				}
			}
		} else {
			return $DCOpsAlias
		}
	}
}