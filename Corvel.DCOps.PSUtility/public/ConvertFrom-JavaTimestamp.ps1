function ConvertFrom-JavaTimestamp {
   [CmdletBinding()]
   param (
      [Parameter(ValueFromPipeline)]
      [long]$JavaTimestamp = 0,
      [switch]$LocalTime
   )
   begin{}
   process{
      if ($LocalTime) {
         ([datetime]'1970-01-01Z').ToUniversalTime().AddMilliseconds($JavaTimestamp).ToLocalTime()
      }
      else {
         ([datetime]'1970-01-01Z').ToUniversalTime().AddMilliseconds($JavaTimestamp)
      }
   }
   end{}
}
