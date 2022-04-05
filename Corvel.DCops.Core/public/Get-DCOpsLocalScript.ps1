function Get-DCOpsLocalScript {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$true)]
		[string]$Name,
		[Parameter(Mandatory=$true)]
		[System.Version]$RequiredVersion,
		[ValidateNotNullOrEmpty()]
		[guid]$CorrelationID = (New-Guid)
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	Write-DCOpsMessage -Message 'Execution Started' -LogLevel VERBOSE -CorrelationID $CorrelationID

	$InstalledScript = Get-InstalledScript -Name $Name -RequiredVersion $RequiredVersion.ToString() -ErrorAction SilentlyContinue

	Write-DCOpsMessage -Message 'Execution Finished' -LogLevel VERBOSE -CorrelationID $CorrelationID
	return $InstalledScript
	
}