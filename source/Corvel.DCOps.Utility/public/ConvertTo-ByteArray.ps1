function ConvertTo-ByteArray {
    [CmdletBinding()]
    [OutputType([byte[]])]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        # The string to convert to a byte array
        [string]$String
    )
    begin{}
    process {
       return [System.Text.Encoding]::ASCII.GetBytes($String)
    }
    end{}
 }
