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
      [string]$Access = 'Read',
      [ValidateNotNullOrEmpty()]
      [string]$DCOpsHost = (Get-DCOpsLocalSetting -Name 'dcopshost')
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
   
   $SavedProgressPreference = $ProgressPreference
   $ProgressPreference = 'SilentlyContinue'

   $Uri = "$DCOpsHost/jsondata/protectedaccess.json"
   $Headers = @{
      'Accept' = 'application/json'
   }

   try {
      $WebResponse = Invoke-WebRequest -Uri $Uri -Headers $Headers -Method Get -Verbose:$false -UseBasicParsing -ErrorAction SilentlyContinue
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