function Get-DCOpsVRLILogLevel {
	[CmdletBinding()]
	param()

	return Get-DCOpsLocalSetting -Key 'dcopsvrliloglevel' -DefaultValue $script:DCOpsVRLILogLevelDefault
	
}