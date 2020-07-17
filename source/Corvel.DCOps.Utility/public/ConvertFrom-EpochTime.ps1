Function ConvertFrom-EpochTime {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$True, ValueFromPipeline)]
		[Int64]$EpochTime,
		[switch]$ToLocalTime
	)

   begin {}
   process {
      [datetime]$EpochDate = Get-Date "1/1/1970"
      if ($ToLocalTime) {
         return (($EpochDate.AddMilliseconds($EpochTime)).ToLocalTime())
      } else {
         return ($EpochDate.AddMilliseconds($EpochTime))
      }
   }
}