function Set-DCOpsCredential {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [CmdletBinding(DefaultParameterSetName='Password', SupportsShouldProcess)]
    [OutputType('DCOpsCredential')]
    param (
       [Parameter(Mandatory=$true, ParameterSetName='Password')]
       [Parameter(Mandatory=$true, ParameterSetName='SecureString')]
       [Parameter(Mandatory=$true, ParameterSetName='PSCredential')]
       [ValidateNotNullOrEmpty()]
       # Host name for the password being added
       [string]$HostName,

       [Parameter(Mandatory=$true, ParameterSetName='Password')]
       [Parameter(Mandatory=$true, ParameterSetname='SecureString')]
       [ValidateNotNullOrEmpty()]
       [string]$UserName,

       [Parameter(ParameterSetName='Password')]
       [Parameter(ParameterSetName='SecureString')]
       [Parameter(ParameterSetName='PSCredential')]
       [ValidateNotNullOrEmpty()]
       [string]$Description,

       [Parameter(Mandatory=$true, ParameterSetName='Password')]
       [ValidateNotNullOrEmpty()]
       [string]$Password,

       [Parameter(Mandatory=$true, ParameterSetName='SecureString')]
       [ValidateNotNullOrEmpty()]
       [securestring]$SecureString,

       [Parameter(Mandatory=$true, ParameterSetName='PSCredential')]
       [ValidateNotNullOrEmpty()]
       [pscredential]$PSCredential,

       [Parameter(Mandatory=$true, ParameterSetName='DCOpsCredential')]
       [ValidateNotNullOrEmpty()]
       [PSTypeName('DCOpsCredential')]$DCOpsCredential,

       [ValidateNotNullOrEmpty()]
       [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
    )

    $CredentialStore = Import-DCOpsCredentialFile -DCOpServer $DCOpServer
    if ($null -eq $CredentialStore) {
       throw 'Unable to load credential file.'
    }

    $CreateParams = @{
       SecureKey = Get-DCOpsMasterKey
    }

    switch ($PSCmdlet.ParameterSetName) {
       'Password' {
          $CreateParams['HostName'] = $HostName
          $CreateParams['UserName'] = $UserName
          $CreateParams['Password'] = $Password
          if ($PSBoundParameters.ContainsKey('Description')) { $CreateParams['Description'] = $Description }
       }
       'SecureString' {
          $CreateParams['HostName'] = $HostName
          $CreateParams['UserName'] = $UserName
          $CreateParams['SecureString'] = $SecureString
          if ($PSBoundParameters.ContainsKey('Description')) { $CreateParams['Description'] = $Description }
       }
       'PSCredential' {
          $CreateParams['HostName'] = $HostName
          $CreateParams['UserName'] = $PSCredential.UserName
          $CreateParams['SecureString'] = $PSCredential.Password
          if ($PSBoundParameters.ContainsKey('Description')) { $CreateParams['Description'] = $Description }
       }
       'DCOpsCredential' {
          $CreateParams['HostName'] = $DCOpsCredential.HostName
          $CreateParams['UserName'] = $DCOpsCredential.UserName
          $CreateParams['SecureString'] = $DCOpsCredential.Password
          if ($DCOpsCredential.Description.Length -ne 0) { $CreateParams['Description'] = $DCOpsCredential.Description }
       }
    }
    $SearchParams = @{
       HostName = $CreateParams['HostName']
       UserName = $CreateParams['UserName']
    }
    if ($CreateParams.ContainsKey('Description')) { $SearchParams['Description'] = $CreateParams['Description'] }

    $Credential = Get-DCOpsCredential @SearchParams -DCOpServer $DCopServer
    if ($Credential) {
       $CredentialStore.Remove($Credential) | Out-Null
    }

    $Credential = New-DCOPsCredentialObject @CreateParams
    if ($PSCmdlet.ShouldProcess("$($Credential.UserName)@$($Credential.HostName)", "Updating DCOps Credential")) {
       $CredentialStore.Add($Credential) | Out-Null
       Export-DCOpsCredentialFile -InputObject $CredentialStore -DCOpServer $DCopServer
    }

    return $Credential

 }