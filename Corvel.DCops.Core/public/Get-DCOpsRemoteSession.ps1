function Get-DCOpsRemoteSession {
	[CmdletBinding(DefaultParameterSetName='RemoteAccount')]
	[OutputType([System.Management.Automation.Runspaces.PSSession])]
	param (
		[ValidateNotNullOrEmpty()]
		[string]$RemoteComputer = (Get-DCOpsSharedSetting -Key 'scriptingserver'),
		[Parameter(ParameterSetName='RemoteCredential', Mandatory = $true)]
		[pscredential]$RemoteCredential,
		[Parameter(ParameterSetName='RemoteAccount')]
		[ValidateNotNullOrEmpty()]
		[string]$RemoteAccount = (Get-DCOpsSharedSetting -Key 'scriptingaccount'),
		[guid]$CorrelationID = (New-Guid)
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	Write-DCOpsMessage -Message 'Execution Started' -LogLevel VERBOSE -CorrelationID $CorrelationID

	if (-not $PSBoundParameters.ContainsKey('RemoteAccount')) {
		$RemoteCredential = Get-DCOpsCredential -Host $RemoteComputer -UserName $AccountName -AsPSCredential
		if (-not $DCOpsCredential) {
			Write-DCOpsMessage -Message "Credential '$RemoteAccount' not found." -LogLevel WARNING -CorrelationID $CorrelationID
			return
		}
	}

	$DCOpsSession = Get-PSSession -ComputerName $RemoteComputer -Credential $RemoteCredential -ErrorAction SilentlyContinue
	if (-not $DCOpsSession) {
		$DCOpsSession = New-PSSession -ComputerName $RemoteComputer -Credential $RemoteCredential -ErrorAction SilentlyContinue
		if (-not $DCOpsSession) {
			Write-DCOpsMessage "Unable to create session to '$RemoteComputer'" -LogLevel WARNING -CorrelationID $CorrelationID
			return
		}
	}
	if ($DCOpsSession.State -eq 'Disconnected') {
		$DCOpsSession = Connect-PSSession -ComputerName $RemoteComputer -Credential $RemoteCredential -ErrorAction SilentlyContinue
		if (-not $DCOpsSession) {
			Write-DCOpsMessage "Unable to create session to '$RemoteComputer'" -LogLevel WARNING -CorrelationID $CorrelationID
			return
		}
	}
	Write-DCOpsMessage -Message 'Execution Finished' -LogLevel VERBOSE -CorrelationID $CorrelationID
	return $DCOpsSession

}