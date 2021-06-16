function Disable-DCOpsLogging {
	[CmdletBinding()]
	param (
		[switch]$SaveCurrent
	)

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	if ($SaveCurrent) {
		$SavedLevels = @{
			FileLogLevel = Get-DCOpsFileLogLevel
			VRLILogLevel = Get-DCOpsVRLILogLevel
		}
	}
	
	Set-DCOpsFileLogLevel -LogLevel 'NONE'
	Set-DCOpsVRLILogLevel -LogLevel 'NONE'

	if ($LoggingLevels) {
		return $SavedLevels
	}
}