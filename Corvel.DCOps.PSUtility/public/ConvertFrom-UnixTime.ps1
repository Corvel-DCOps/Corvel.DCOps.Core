function ConvertFrom-UnixTime {
   [CmdletBinding()]
   param (
      [Parameter(ValueFromPipeline)]
      [long]$UnixTime = 0,
      [switch]$LocalTime
   )
   
   process {
      if ($LocalTime) {
         ([datetime]'1970-01-01Z').ToUniversalTime().AddSeconds($UnixTime).ToLocalTime()
      }
      else {
         ([datetime]'1970-01-01Z').ToUniversalTime().AddSeconds($UnixTime)
      }
   }
   
}