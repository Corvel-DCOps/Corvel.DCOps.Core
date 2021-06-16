function Enable-DCOpsLogging {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$true, ParameterSetName ='HashTable')]
		[hashtable]$LogLevel,
		[Parameter(ParameterSetName='DefaultValue')]
		[ValidateSet('VERBOSE', 'INFORMATION', 'WARNING', 'ERROR', 'NONE')]
		[string]$FileLogLevel = $script:DCOpsFileLogLevelDefault,
		[Parameter(ParameterSetName='DefaultValue')]
		[ValidateSet('VERBOSE', 'INFORMATION', 'WARNING', 'ERROR', 'NONE')]
		[string]$VRLILogLevel = $script:DCOpsVRLILogLevelDefault
	)

	if ($PSBoundParameters.ContainsKey('LogLevel')) {
		if ($LogLevel.ContainsKey('FileLogLevel')) { $FileLogLevel = $LogLevel.FileLogLevel }
		if ($LogLevel.ContainsKey('VRLILogLevel')) { $VRLILogLevel = $LogLevel.VRLILogLevel }
	}

	Set-DCOpsFileLogLevel $FileLogLevel
	Set-DCOpsVRLILogLevel $VRLILogLevel

}