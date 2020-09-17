function Import-DCOpsCredentialFile {
   [CmdletBinding()]
   [OutputType([System.Collections.Generic.List[PSCustomObject]])]
   param (
      [ValidateNotNullOrEmpty()]
      # The server to retreive the data from, specified as http[s]://servername:[port]. If not specified, the 'dcopserver' local setting is used.
      [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
   
   $CredentialStore = [System.Collections.Generic.List[PSCustomObject]]@()

   if (-not ($MasterKey = Get-DCOpsMasterKey)) {
      throw 'DCOps Master Key not found.'
      return
   }

   # Now, let's get the credentials from the server
   $Credentials = Get-DCOpsJsonDataFile -Name 'dcopscredentials' -DCOpServer $DCOpServer
   if ($null -eq $Credentials) {
      throw 'Unable to load credential file.'
      return
   }

   if ($Credentials -eq [string]::Empty) {
      # Either the file wasn't there or was empty
      return ,$CredentialStore
   }
   
   # Let's validate what we got back to make sure everything is kosher
   # And then we'll convert them to our credential objects.
   $ValidFields = @('hostname', 'username', 'description', 'encryptedpassword')
   foreach ($Credential in $Credentials) {
      # Compare-Object returns all of the objects that are different, so we don't actually want
      # any output from the call
      $ExistFields = ($Credential | Get-Member -MemberType NoteProperty).Name
      if (-not (Compare-Object -ReferenceObject $ValidFields -DifferenceObject $ExistFields)) {
         $Params = @{
            HostName = $Credential.HostName
            UserName = $Credential.UserName
            Description  = $Credential.Description
            EncryptedPassword = $Credential.EncryptedPassword
            SecureKey = $MasterKey
         }
         if ($NewCredential = New-DCopsCredentialObject @Params) {
            $CredentialStore.Add($NewCredential) | Out-Null
         } else {
            Write-Warning "Unable to convert credential '$($Credential.UserName)@$($Credential.HostName)'"
         }
      }
   }

   return ,$CredentialStore
 }