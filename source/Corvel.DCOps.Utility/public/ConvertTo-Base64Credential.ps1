Function ConvertTo-Base64Credential {
   [CmdletBinding(DefaultParameterSetName='StringPassword')]
   param (
      [Parameter(Mandatory=$true, ParameterSetName='StringPassword', Position=0, ValueFromPipelineByPropertyName)]
      [Alias('User')]
      [string]$UserName,
      [Parameter(Mandatory=$true, ParameterSetName='StringPassword', Position=1, ValueFromPipelineByPropertyName)]
      [string]$Password,
      [Parameter(Mandatory=$true, ParameterSetName='PSCredential')]
      [pscredential]$PSCredential
   )
   begin {}
   process {
      if ($PSBoundParameters.ContainsKey('PSCredential')) {         
         $UserName = $PSCredential.UserName
         $Password = $PSCredential.GetNetworkCredential().Password
      }
      $EncodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("${UserName}:${Password}"))
      return ,$EncodedCreds
   }
}