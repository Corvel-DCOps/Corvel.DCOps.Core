function Write-DCOpsLogFile {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[string]$Message,		
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
		# These handle how we handle mutexes/retries when writing to the file
		[ValidateRange(1, 10)]
		[int]$WaitTime = 1,
		[ValidateRange(1, 10)]
		[int]$MaxRetries = 1,
		# Return the LogRecord
		[switch]$PassThru
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	$DCOpsLogFile = Get-DCOpsLogFile
	$DCOpsLogFileMutexName = "Global\DCOpsLogFile-$(Get-Date -Format yyyyMMdd)"
	if (-not (Test-DCOpsLoggingLevel $LogLevel (Get-DCOpsFileLogLevel))) {
		return
	}

	$DCOpsLogRecord = [pscustomobject][ordered]@{PSTypeName ='DCOpsLogRecord'
		TimeStamp = Get-Date
		CorrelationID = $CorrelationID
		ExecutionHost = $ExecutionHost
		CurrentUser = $CurrentUser
		ProcessId = $PID
		MessageSource = $MessageSource
		LogLevel = $LogLevel.ToUpper()		
		Message = $Message
	}

	$DCOpsLogFileMutex = [System.Threading.Mutex]::new($false, $DCOpsLogFileMutexName)
	$RetryCount = 0
	while ($RetryCount -lt $MaxRetries) {
		if ($DCOpsLogFileMutex.WaitOne(($WaitTime * 1000))) {
			$DCOpsLogRecord | Export-Csv -Path $DCOpsLogFile -Append -NoTypeInformation -WhatIf:$false
			$DCOpsLogFileMutex.ReleaseMutex()
			break
		} else {
			Write-DCOpsVerbose -Message "[$CorrelationID] Timeout waiting for file mutex"
			$RetryCount++
		}
	}
	if ($RetryCount -ge $MaxRetries) {
		Write-DCOpsWarning -Message "[$CorrelationID] Failed to write to log file '$DCOpsLogFileName'"
	}

	if ($PassThru) {
		return $DCOpsLogRecord
	}
}