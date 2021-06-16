function Write-DCOpsWarning {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$True, Position=0)]
		[string]$Message,
		[Parameter(Position=1)]
      [string]$MessageSource = ((Get-PSCallStack)[0].Command)
	)

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	$warningMessage = "{0} {1} {2}" -f (Get-Date -Format "MM/dd/yyyy HH:mm:ss"), $MessageSource, $Message
	Write-Warning $warningMessage
	
}