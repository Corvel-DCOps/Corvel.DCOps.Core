function Export-DCOpsCredentialFile {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([System.Void])]
    param (
       [Parameter(Mandatory = $true)]
       [ValidateNotNullOrEmpty()]
       [System.Collections.Generic.List[PSCustomObject]]$InputObject
    )
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    
    $ExportObject = $InputObject | Select-Object HostName, UserName, Description, @{N='encryptedpassword'; E={$_.ToEncryptedString()}}
    if ($PSCmdlet.ShouldProcess('Saving DCOps Credential File', $null, $null)) {
       Set-DCOpsJsonDataFile -Name 'dcopscredentials' -InputObject $ExportObject
    }
 }