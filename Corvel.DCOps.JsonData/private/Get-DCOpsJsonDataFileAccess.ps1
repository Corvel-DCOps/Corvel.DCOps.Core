function Get-DCOpsJsonDataFileAccess {
   [CmdletBinding()]
   [OutputType([System.Void], [bool])]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$Name,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$Caller,
      [ValidateSet('Read', 'Write')]
      [string]$Access = 'Read'
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
   $DCOpsHost = (Get-DCOpsLocalSetting -Name 'dcopshost')
   $SavedProgressPreference = $ProgressPreference
   $ProgressPreference = 'SilentlyContinue'

   $Uri = "$DCOpsHost/jsondata/protectedaccess.json"
   $Headers = @{
      'Accept' = 'application/json'
   }

   $Params = @{
      Uri = $Uri
      Headers = $Headers
      Method = 'Get'
      Verbose = $false
      UseBasicParsing = $true
      ErrorAction = 'SilentlyContinue'
   }
   if ($PSEdition -eq 'Core') {
      $Params['SkipCertificateCheck'] = $true
   } else {
      Disable-SslCertificateValidation
   }
   try {
      $WebResponse = Invoke-WebRequest @Params
   } catch {
      return $null
   } finally {
      $ProgressPreference = $SavedProgressPreference
   }
   if ($WebResponse.StatusCode -ne 200) {
      return $null
   }
   $AccessList = $WebResponse.Content | ConvertFrom-Json | ConvertTo-HashTable

   # If the file isn't in the list, then grant access
   if (-not ($AccessList.ContainsKey($Name))) { return $true}
   # If the caller is in the requested access list, grant access
   return ($Caller -in ($AccessList[$Name][$Access]))
}
