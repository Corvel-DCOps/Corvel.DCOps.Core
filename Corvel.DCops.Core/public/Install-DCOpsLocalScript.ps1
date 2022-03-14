function Install-DCOpsLocalScript {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[Parameter(Mandatory = $true)]
		[System.Version]$RequiredVersion,
		[ValidateNotNullOrEmpty()]
		[string]$Repository = (Get-DCOpsSharedSetting -Key 'psrepository'),
		[guid]$CorrelationID = (New-Guid)
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	Write-DCOpsMessage -Message 'Execution Started' -LogLevel VERBOSE -CorrelationID $CorrelationID

	$InstalledScript = Get-InstalledScript -Name $Name -ErrorAction SilentlyContinue
	try {
		if (-not $InstalledScript) {
			# New Install
			$InstalledScript = Install-Script -Repository $Repository -Name $Name -RequiredVersion $RequiredVersion.ToString() -Scope AllUsers -Force -PassThru -ErrorAction Stop
		} else {
			# Possibly Update
			if ($RequiredVersion.CompareTo([System.Version]$InstalledScript.Version) -gt 0 ) {
				$InstalledScript = Update-Script -Name $Name -RequiredVersion $RequiredVersion.ToString() -PassThru -ErrorAction Stop
			}
		}
	} catch {
		Write-DCOpsMessage -Message "Unable to install/update script '$Name'" -LogLevel ERROR -CorrelationID $CorrelationID
	}
	Write-DCOpsMessage -Message 'Execution Finished' -LogLevel VERBOSE -CorrelationID $CorrelationID
	return $InstalledScript
}