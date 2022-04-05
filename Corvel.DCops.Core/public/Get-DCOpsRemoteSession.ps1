function Get-DCOpsRemoteSession {
	[CmdletBinding()]
	[OutputType([System.Management.Automation.Runspaces.PSSession])]
	param (
		[ValidateNotNullOrEmpty()]
		[string]$Computer = (Get-DCOpsSharedSetting -Key 'scriptingserver'),
		[ValidateNotNullOrEmpty()]
		[pscredential]$Credential = (Get-DCOpsCredential -Host $Computer -UserName (Get-DCOpsSharedSetting -Key 'scriptingaccount') -AsPSCredential),
		[guid]$CorrelationID = (New-Guid)
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	Write-DCOpsMessage -Message 'Execution Started' -LogLevel VERBOSE -CorrelationID $CorrelationID
	
	$DCOpsSession = Get-PSSession -ComputerName $Computer -Credential $Credential -ErrorAction SilentlyContinue
	if (-not $DCOpsSession) {
		$DCOpsSession = New-PSSession -ComputerName $Computer -Credential $Credential -ErrorAction SilentlyContinue
		if (-not $DCOpsSession) {
			Write-DCOpsMessage "Unable to create session to '$Computer'" -LogLevel WARNING -CorrelationID $CorrelationID
			return
		}
	}
	if ($DCOpsSession.State -eq 'Disconnected') {
		$DCOpsSession = Connect-PSSession -ComputerName $Computer -Credential $Credential -ErrorAction SilentlyContinue
		if (-not $DCOpsSession) {
			Write-DCOpsMessage "Unable to create session to '$Computer'" -LogLevel WARNING -CorrelationID $CorrelationID
			return
		}
	}
	Write-DCOpsMessage -Message 'Execution Finished' -LogLevel VERBOSE -CorrelationID $CorrelationID
	return $DCOpsSession

}