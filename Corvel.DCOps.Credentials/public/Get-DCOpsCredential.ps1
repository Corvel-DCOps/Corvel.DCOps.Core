function Get-DCOpsCredential {
    [CmdletBinding()]
    [OutputType([System.Collections.Generic.List[PSCustomObject]])]
    param (
       [ValidateNotNullOrEmpty()]
       [SupportsWildcards()]
       [string]$HostName,
       [ValidateNotNullOrEmpty()]
       [SupportsWildcards()]
       [string]$UserName,
       [ValidateNotNullOrEmpty()]
       [SupportsWildcards()]
       [string]$Description,
       [ValidateNotNullOrEmpty()]
       [string]$DCOpServer = (Get-DCOpsLocalSetting 'dcopserver')
    )

    $CredentialStore = Import-DCOpsCredentialFile -DCOpServer $DCOpServer
    if ($null -eq $CredentialStore) {
       throw 'Unable to load credential file.'
       return
    }
    # Build our Where clause
    $WhereArray = @()
    if ($PSBoundParameters.ContainsKey('HostName')) {
       if ([System.Management.Automation.WildcardPattern]::ContainsWildcardCharacters($Hostname)) {
          $WhereArray += '$_.HostName -like $HostName'
       } else {
          $WhereArray += '$_.HostName -eq $HostName'
       }
    }
    if ($PSBoundParameters.ContainsKey('UserName')) {
       if ([System.Management.Automation.WildcardPattern]::ContainsWildcardCharacters($UserName)) {
          $WhereArray += '$_.UserName -like $UserName'
       } else {
          $WhereArray += '$_.UserName -eq $UserName'
       }
    }
    if ($PSBoundParameters.ContainsKey('Description')) {
       if ([System.Management.Automation.WildcardPattern]::ContainsWildcardCharacters($Description)) {
          $WhereArray += '$_.Description -like $Description'
       } else {
          $WhereArray += '$_.Description -eq $Description'
       }
    }
    if ($WhereArray.Count -eq 0) {
       return ,$CredentialStore.AsReadOnly()
    }

    $WhereString = $WhereArray -join ' -and '

    $WhereBlock = [scriptblock]::Create($WhereString)

    $SearchResults = $CredentialStore | Where-Object -FilterScript $WhereBlock
    if ($SearchResults) {
      return ,$SearchResults       
    }
 }