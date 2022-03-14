function Set-DCOpsVRLILogLevel {
	[CmdletBinding()]
	param (
		[ValidateSet('NONE', 'VERBOSE', 'INFORMATION', 'WARNING', 'ERROR')]
		[string]$LogLevel = 'VERBOSE'
	)

	Set-DCOpsLocalSetting -Key 'dcopsvrliloglevel' -Value $LogLevel.ToUpper()

}