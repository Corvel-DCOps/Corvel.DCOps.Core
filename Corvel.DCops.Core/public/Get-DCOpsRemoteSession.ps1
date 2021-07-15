function Get-DCOpsRemoteSession {
	[CmdletBinding(DefaultParameterSetName='Account')]
	[OutputType([System.Management.Automation.Runspaces.PSSession])]
	param (
		[ValidateNotNullOrEmpty()]
		[string]$Computer = (Get-DCOpsSharedSetting -Key 'scriptingserver'),
		[Parameter(ParameterSetName='Credential', Mandatory = $true)]
		[pscredential]$Credential,
		[Parameter(ParameterSetName='Account')]
		[ValidateNotNullOrEmpty()]
		[string]$Account = (Get-DCOpsSharedSetting -Key 'scriptingaccount'),
		[guid]$CorrelationID = (New-Guid)
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	Write-DCOpsMessage -Message 'Execution Started' -LogLevel VERBOSE -CorrelationID $CorrelationID
	
	if ( $PSCmdlet.ParameterSetName -eq 'Account' ) {
		$Credential = Get-DCOpsCredential -Host $Computer -UserName $Account -AsPSCredential
		if (-not $DCOpsCredential) {
			Write-DCOpsMessage -Message "Credential '$Account' not found." -LogLevel WARNING -CorrelationID $CorrelationID
			return
		}
	}

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