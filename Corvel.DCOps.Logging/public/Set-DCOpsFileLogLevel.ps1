function Set-DCOpsFileLogLevel {
	[CmdletBinding()]
	param (
		[ValidateSet('NONE', 'VERBOSE', 'INFORMATION', 'WARNING', 'ERROR')]
		[string]$LogLevel = 'INFORMATION'
	)

	Set-DCOpsLocalSetting -Key 'dcopsfileloglevel' -Value $LogLevel.ToUpper()
	
}