function Test-DCOpsLoggingLevel {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$true, Position = 0)]
		[ValidateSet('VERBOSE', 'INFORMATION', 'WARNING', 'ERROR')]
		[string]$LogLevel,
		[Parameter(Mandatory=$true, Position = 1)]
		[ValidateSet('NONE','VERBOSE', 'INFORMATION', 'WARNING', 'ERROR')]
		[string]$TargetLogLevel
	)

	return ($script:DCOpsLogLevels.IndexOf($LogLevel) -ge $script:DCOpsLogLevels.IndexOf($TargetLogLevel))
}