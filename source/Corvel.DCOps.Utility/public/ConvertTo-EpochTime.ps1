Function ConvertTo-EpochTime {
	[CmdletBinding()]
	param (
      [Parameter(ValueFromPipeline)]
		[datetime]$DateToConvert = (Get-Date)
	)
	$UTCDate = $DateToConvert.ToUniversalTime()
	$EpochDate = Get-Date "1/1/1970"

	$TimeSpan = New-TimeSpan -Start $EpochDate -End $UTCDate
	[Int64]$EpochTime = $TimeSpan.TotalMilliseconds
	return $EpochTime

}
