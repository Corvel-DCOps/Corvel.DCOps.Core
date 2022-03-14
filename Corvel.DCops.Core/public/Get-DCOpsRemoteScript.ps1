function Get-DCOpsRemoteScript {
	[CmdletBinding(DefaultParameterSetName = 'Computer')]
	param (
		[Parameter(Mandatory = $true, ParameterSetName = 'Session')]
		[System.Management.Automation.Runspaces.PSSession]$Session,
		[Parameter(ParameterSetName = 'Computer')]
		[ValidateNotNullOrEmpty()]
		[string]$Computer = (Get-DCOPsSharedSetting -Key 'scriptingserver'),
		[Parameter(ParameterSetName = 'Computer')]
		[ValidateNotNullOrEmpty()]
		[PSCredential]$Credential = (Get-DCOpsCredential -Host $Computer -UserName (Get-DCOpsSharedSetting -Key 'scriptingaccount') -AsPSCredential ),
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[ValidateNotNullOrEmpty()]
		[System.Version]$RequiredVersion,
		[guid]$CorrelationID = (New-Guid)
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	Write-DCOpsMessage -Message 'Execution Started' -LogLevel VERBOSE -CorrelationID $CorrelationID

	if (-not $PSBoundParameters.ContainsKey('Session')) {
		$Session = Get-DCOpsRemoteSession -Computer $Computer -Credential $Credential -CorrelationID $CorrelationID
		if (-not $Session) {
			return
		}
	}
	$Params = @{ 
		Name = $Name
	}
	if ($PSBoundParameters.ContainsKey('RequiredVersion')) {
		$Params['RequiredVersion'] = $RequiredVersion.ToString()
	}
	$InstalledScript = Invoke-Command -Session $Session -ScriptBlock { Get-InstalledScript @using:Params }

	Write-DCOpsMessage -Message 'Execution Finished' -LogLevel VERBOSE -CorrelationID $CorrelationID
	return $InstalledScript
}