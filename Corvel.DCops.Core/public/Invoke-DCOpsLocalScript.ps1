function Invoke-DCOpsLocalScript {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$true)]
		[PSTypeNameAttribute('DCOpsScript')]
		[object]$Script,
		[Parameter(Mandatory=$true)]
		[hashtable]$Parameters,
		[switch]$InstallIfMissing,
		[ValidateNotNullOrEmpty()]
		[guid]$CorrelationID = (New-Guid)
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	Write-DCOpsMessage -Message 'Execution Started' -LogLevel VERBOSE -CorrelationID $CorrelationID
	$Results = [PSCustomObject][ordered] @{ PSTypeName = 'DCOpsScriptResult'
		Result = $false
		ScriptResult = $null
		ErrorRecord = $null
	}
	
	$InstalledScript = Get-DCOpsLocalScript -Name $Script.Name -RequiredVersion $Script.Version -CorrelationID $CorrelationID
	if (-not $InstalledScript)  {
		if ($InstallIfMissing) {
			$InstalledScript = Install-DCOpsLocalScript -Name $Script.Name -RequiredVersion $Script.RequiredVersion -CorrelationID $CorrelationID
		}
		if (-not $InstalledScript) {
			$Results.ErrorRecord = New-DCOpsErrorRecord -Message "Script '$($Script.Name)' not installed" -Id 'ScriptNotInstalled' -Category NotInstalled -Target $Script
		}
	}

	if ($InstalledScript) {
		$ScriptPath = Join-Path $InstalledScript.InstalledLocation "$($InstalledScript.Name).ps1"
		try {
			$Results.ScriptResult = & $ScriptPath @Parameters
			$Results.Result = $true
		} catch {
			$Results.ErrorRecord = $Error
		}
	}

	Write-DCOpsMessage -Message 'Execution Finished' -LogLevel VERBOSE -CorrelationID $CorrelationID
	return $Results
}