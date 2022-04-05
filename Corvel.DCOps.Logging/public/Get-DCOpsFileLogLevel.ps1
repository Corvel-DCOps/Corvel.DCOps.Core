function Get-DCOpsFileLogLevel {
	[CmdletBinding()]
	param()

	return Get-DCOpsLocalSetting -Key 'dcopsfileloglevel' -DefaultValue $script:DCOpsFileLogLevelDefault

}