function Get-DCOpsLogPath {
	[CmdletBinding()]
	param()

	return Get-DCOpsLocalSetting -Key 'dcopslogpath' -DefaultValue $script:DCOpsLogPathDefault

}