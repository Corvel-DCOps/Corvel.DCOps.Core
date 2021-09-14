function New-DCOpsErrorRecord {
	[CmdletBinding()]
	[OutputType([System.Management.Automation.ErrorRecord])]
	param (
		[Parameter(Mandatory=$true)]
		[string]$Message,
		[ValidateNotNullOrEmpty()]
		[string]$Id = 'NotSpecified',
		[ValidateNotNullOrEmpty()]
		[System.Management.Automation.ErrorCategory]$Category = 'NotSpecified',
		[object]$Target,
		[ValidateNotNullOrEmpty()]
		[guid]$CorrelationID = (New-Guid)
	)

	$Exception = [System.ApplicationException]::new($Message)
	$ErrorRecord = [System.Management.Automation.ErrorRecord]::new($Exception, $Id, $Category, $Target)
	return $ErrorRecord
}