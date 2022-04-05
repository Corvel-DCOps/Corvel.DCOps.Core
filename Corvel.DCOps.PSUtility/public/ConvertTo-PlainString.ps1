function ConvertTo-PlainString {
   [CmdletBinding()]
   [OutputType([string])]
   param (
      [Parameter(Mandatory = $true, ValueFromPipeline)]
      [securestring]$SecureString
   )
   
   process {
      $_BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
      $_PlainString = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($_BSTR)
      return $_PlainString
   }
   
}
