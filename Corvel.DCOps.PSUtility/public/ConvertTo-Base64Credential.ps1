Function ConvertTo-Base64Credential {
   [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '', Scope = 'Function', Target = '*')]
   [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '', Scope = 'Function', Target = '*')]
   [CmdletBinding(DefaultParameterSetName = 'StringPassword')]
   [OutputType([string])]
   param (
      [Parameter(Mandatory = $true, ParameterSetName = 'StringPassword', Position = 0, ValueFromPipelineByPropertyName)]
      [Alias('User')]
      [string]$UserName,
      [Parameter(Mandatory = $true, ParameterSetName = 'StringPassword', Position = 1, ValueFromPipelineByPropertyName)]
      [string]$Password,
      [Parameter(Mandatory = $true, ParameterSetName = 'PSCredential')]
      [pscredential]$PSCredential
   )
   
   process {
      if ($PSBoundParameters.ContainsKey('PSCredential')) {
         $UserName = $PSCredential.UserName
         $Password = $PSCredential.GetNetworkCredential().Password
      }
      $EncodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("${UserName}:${Password}"))
      return $EncodedCreds
   }
}