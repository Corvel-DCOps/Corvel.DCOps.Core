function Install-DCOpsRemoteScript {
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
		[Parameter(Mandatory = $true)]
		[System.Version]$RequiredVersion,
		[ValidateNotNullOrEmpty()]
		[string]$Repository = (Get-DCopsSharedSetting -Key 'psrepository'),
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

	$Params = {
		Session = $Session
		Name = $Name
		CorrelationID = $CorrelationID
	}
	$InstalledScript = Get-DCOpsRemoteScript @Params 
	if ( -not $InstalledScript ) {
		$Params = @{ 
			Name = $Name 
			RequiredVersion = $Version.ToString()
			Scope = 'AllUsers'
			PassThru = $true
			Repository = $Repository
		}
		$InstalledScript = Invoke-Command -Session $Session -ScriptBlock { Install-Script @using:Params }
	} else {
		if ($Version.CompareTo([System.Version]$InstalledScript.Version) -gt 0 ) {
			$Params = @{ 
				Name = $Name 
				RequiredVersion = $Version.ToString()
				PassThru = $true
			}
			$InstalledScript = Invoke-Command -Session $Session -ScriptBlock { Update-Script @using:Params }
	
		}
	}

	Write-DCOpsMessage -Message 'Execution Finished' -LogLevel VERBOSE -CorrelationID $CorrelationID
	return $InstalledScript
}