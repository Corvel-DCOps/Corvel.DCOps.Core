function Get-DCOpsRemoteSession {
	[CmdletBinding(DefaultParameterSetName='AccountName')]
	[OutputType([System.Management.Automation.Runspaces.PSSession])]
	param (
		[ValidateNotNullOrEmpty()]
		[string]$ComputerName = (Get-DCOpsSharedSetting -Key 'scriptingserver'),
		[Parameter(ParameterSetName='PSCredential', Mandatory = $true)]
		[pscredential]$Credential,
		[Parameter(ParameterSetName='AccountName')]
		[ValidateNotNullOrEmpty()]
		[string]$AccountName = (Get-DCOpsSharedSetting -Key 'scriptingaccount'),
		[guid]$CorrelationID = (New-Guid)
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	Write-DCOpsMessage -Message 'Execution Started' -LogLevel VERBOSE -CorrelationID $CorrelationID

	if (-not $PSBoundParameters.ContainsKey('Credential')) {
		$DCOpsCredential = Get-DCOpsCredential -Host $ComputerName -UserName $AccountName
		if (-not $DCOpsCredential) {
			Write-DCOpsMessage -Message "Credential '$AccountName' not found." -LogLevel WARNING -CorrelationID $CorrelationID
			return
		}
		$Credential = $DCOpsCredential.ToPSCredential()
	}

	$DCOpsSession = Get-PSSession -ComputerName $ComputerName -Credential $Credential -ErrorAction SilentlyContinue
	if (-not $DCOpsSession) {
		$DCOpsSession = New-PSSession -ComputerName $ComputerName -Credential $Credential -ErrorAction SilentlyContinue
		if (-not $DCOpsSession) {
			Write-DCOpsMessage "Unable to create session to '$Computername'" -LogLevel WARNING -CorrelationID $CorrelationID
			return
		}
	}
	if ($DCOpsSession.State -eq 'Disconnected') {
		$DCOpsSession = Connect-PSSession -ComputerName $ComputerName -Credential $Credential -ErrorAction SilentlyContinue
		if (-not $DCOpsSession) {
			Write-DCOpsMessage "Unable to create session to '$Computername'" -LogLevel WARNING -CorrelationID $CorrelationID
			return
		}
	}
	Write-DCOpsMessage -Message 'Execution Finished' -LogLevel VERBOSE -CorrelationID $CorrelationID
	return $DCOpsSession

}