function Get-DCOpsServer {
   [CmdletBinding()]
   [OutputType([System.Collections.Generic.List[PSCustomObject]])]
   param (
      [ValidateNotNullOrEmpty()]
      [SupportsWildcards()]
      [string]$ServerType,
      [ValidateNotNullOrEmpty()]
      [SupportsWildcards()]
      [string]$HostName,
      [ValidateNotNullOrEmpty()]
      [SupportsWildcards()]
      [string]$DisplayName,
      [ValidateNotNullOrEmpty()]
      [SupportsWildcards()]
      [string]$Environment,
      [ValidateNotNullOrEmpty()]
      [SupportsWildcards()]
      [string]$Location,
      [ValidateNotNullOrEmpty()]
      [string]$DCOpsHost = (Get-DCOpsLocalSetting -Name 'dcopshost')
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

   $DCOpsServers = Import-DCOpsServerFile -DCOpsHost $DCOpsHost
   
   $WhereArray = @()
   if ($PSBoundParameters.ContainsKey('ServerType')) {
      if ([System.Management.Automation.WildcardPattern]::ContainsWildcardCharacters($ServerType)) {
         $WhereArray += '$_.ServerType -like $ServerType'
      } else {
         $WhereArray += '$_.ServerType -eq $ServerType'
      }
   }
   if ($PSBoundParameters.ContainsKey('HostName')) {
      if ([System.Management.Automation.WildcardPattern]::ContainsWildcardCharacters($HostName)) {
         $WhereArray += '$_.HostName -like $HostName'
      } else {
         $WhereArray += '$_.HostName -eq $HostName'
      }
   }
   if ($PSBoundParameters.ContainsKey('DisplayName')) {
      if ([System.Management.Automation.WildcardPattern]::ContainsWildcardCharacters($DisplayName)) {
         $WhereArray += '$_.DisplayName -like $DisplayName'
      } else {
         $WhereArray += '$_.DisplayName -eq $DisplayName'
      }
   }
   if ($PSBoundParameters.ContainsKey('Environment')) {
      if ([System.Management.Automation.WildcardPattern]::ContainsWildcardCharacters($Environment)) {
         $WhereArray += '$_.Environment -like $Environment'
      } else {
         $WhereArray += '$_.Environment -eq $Environment'
      }
   }
   if ($PSBoundParameters.ContainsKey('Location')) {
      if ([System.Management.Automation.WildcardPattern]::ContainsWildcardCharacters($Location)) {
         $WhereArray += '$_.Location -like $Location'
      } else {
         $WhereArray += '$_.Location -eq $Location'
      }
   }

   if ($WhereArray.Count -eq 0) {
      return ,$DCOpsServers.AsReadOnly()
   }

   $WhereString = $WhereArray -join ' -and '

   $WhereBlock = [scriptblock]::Create($WhereString)

   $SearchResults = $DCOpsServers | Where-Object -FilterScript $WhereBlock
   if ($SearchResults) {
     return ,$SearchResults       
   }
}