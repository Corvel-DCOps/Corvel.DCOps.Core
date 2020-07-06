function Remove-DCOpsCredential {
   [CmdletBinding(SupportsShouldProcess)]
   [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
   param (
      [Parameter(Mandatory=$true, ParameterSetName='Search')]
      [ValidateNotNullOrEmpty()]
      [string]$HostName,
      [Parameter(Mandatory=$true, ParameterSetName='Search')]
      [ValidateNotNullOrEmpty()]
      [string]$UserName,
      [Parameter(Mandatory=$true, ParameterSetName='DCOpCredential')]
      [ValidateNotNullOrEmpty()]
      [PSTypeName('DCOpsCredential')]$DCOpsCredential,
      [ValidateNotNullOrEmpty()]
      [string]$DCOpServer = (Get-DCOpsLocalSetting -Key 'dcopserver')
   )

   if (-not ($CredentialStore = Import-DCOpsCredentialFile -DCOpServer $DCOpServer)) {
      throw 'Unable to load credential file.'
      return
   }
   if ($PSBoundParameters.ContainsKey('HostName')) {
      $Credential = $CredentialStore | Where-Object {$_.HostName -eq $HostName -and  $_.UserName -eq $UserName}
   } else {
      $Credential = $CredentialStore | Where-Object {$_.HostName -eq $DCOpsCredential.HostName -and $_.UserName -eq $DCOpsCredential.UserName }
   }
   if (-not $Credential) {
      Write-Warning "Credential '$UserName@$HostName' not found."
      return
   }
   if ($PSCmdlet.ShouldProcess("$($Credential.UserName)@$($Credential.HostName)", 'Removing credential')) {
      $CredentialStore.Remove($Credential) | Out-Null
      Export-DCOpsCredentialFile -InputObject $CredentialStore -DCOpServer $DCOpServer
   }

}