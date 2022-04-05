function Get-DCOpsEvent {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline)]
		[string]$Message,
		[ValidateSet('INFO', 'WARNING', 'ERROR')]
		[ValidateNotNullOrEmpty()]
		[string]$Level = 'INFO',
		[ValidateNotNullOrEmpty()]
		[guid]$CorrelationID = (New-Guid)
	)

	return [PSCustomObject] [ordered] @{
		Time = Get-Date
		CorrelationID = $CorrelationID
		Level = $Level.ToUpper()
		Message = $Message
	}
}