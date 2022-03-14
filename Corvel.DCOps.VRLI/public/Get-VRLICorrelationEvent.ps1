function Get-VRLICorrelationEvent {
	[CmdletBinding()]
	param (
      [ValidateNotNullOrEmpty()]
      [string]$Server = (Get-DCopsServer -ServerType loginsight -Environment Production).hostname,
      [ValidateRange(1, 65535)]
      [int]$Port = 9543,
		[ValidateNotNullOrEmpty()]
		[PSCredential]$Credential = (Get-DCOpsCredential -HostName $Server -AsPSCredential | Select-Object -First 1),
		[ValidateNotNullOrEmpty()]
		[guid]$CorrelationID =  (Get-Module Corvel.DCOPs.Core).Guid
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	Write-DCOpsMessage -Message 'Execution Started' -LogLevel VERBOSE -CorrelationID $CorrelationID



	Write-DCOpsMessage -Message 'Execution Finished' -LogLevel VERBOSE -CorrelationID $CorrelationID
}