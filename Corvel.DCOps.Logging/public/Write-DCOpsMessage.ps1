function Write-DCOpsMessage {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[string[]]$Message,		
		[ValidateNotNullOrEmpty()]
		[System.Guid]$CorrelationID = (Get-Module Corvel.DCOPs.Core).Guid,
		[ValidateNotNullOrEmpty()]
		[string]$ExecutionHost = $env:COMPUTERNAME,
		[ValidateNotNullOrEmpty()]
		[string]$CurrentUser = [Security.Principal.WindowsIdentity]::GetCurrent().Name,
		[ValidateNotNullOrEmpty()]
		[string]$MessageSource = (Get-PSCallStack)[0].Command,
		[ValidateSet('VERBOSE', 'INFORMATION', 'WARNING', 'ERROR')]
		[string]$LogLevel = 'INFORMATION',
		[ValidateNotNullOrEmpty()]
		[string]$VRLIServer = (Get-DCOpsServer -ServerType loginsight -Environment Production).hostname,
		[switch]$NoOutput,
		[switch]$NoLogFile,
		[switch]$NoVRLI
	)

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	
	# Write to the streams/console
	if (-not $NoOutput) {
		switch ($LogLevel) {
			'VERBOSE' { Write-DCOpsVerbose -Message "[$CorrelationID] $($Message[0])" -MessageSource $MessageSource }
			'INFORMATION' { Write-DCOpsInformation -Message "[$CorrelationID] $($Message[0])" -MessageSource $MessageSource }
			'WARNING' { Write-DCOpsWarning -Message "[$CorrelationID] $($Message[0])" -MessageSource $MessageSource }
			'ERROR' { Write-Error -Message "[$CorrelationID] $($Message[0])" }
		}
	}

	$Params = @{
		CorrelationID = $CorrelationID
		ExecutionHost = $ExecutionHost
		CurrentUser = $CurrentUser
		MessageSource = $MessageSource
		LogLevel = $LogLevel
	}
	# Write to the log file 
	if (-not $NoLogFile) {
		Write-DCOpsLogFile -Message ($Message -join '|') @Params
	}

	# Write to Log Insight
	if (-not $NoVRLI) {
		Write-DCOpsVRLIEvent -Server $VRLIServer -Message ($Message -join "`r`n") @Params
	}
}