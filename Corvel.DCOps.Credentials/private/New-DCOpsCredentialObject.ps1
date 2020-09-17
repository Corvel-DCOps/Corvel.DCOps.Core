function New-DCopsCredentialObject {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingConvertToSecureStringWithPlainText', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [CmdletBinding(DefaultParameterSetName='String')]
    [OutputType('DCOpsCredential')]
    param (
       [Parameter(Mandatory=$true)]
       [ValidateNotNullOrEmpty()]
       [string]$HostName,
       [Parameter(Mandatory=$true)]
       [ValidateNotNullOrEmpty()]
       [string]$UserName,
       [Parameter(Mandatory=$true, ParameterSetName = 'String')]
       [ValidateNotNullOrEmpty()]
       [string]$Password,
       [Parameter(Mandatory=$true, ParameterSetName = 'EncryptedString')]
       [ValidateNotNullOrEmpty()]
       [string]$EncryptedPassword,
       [Parameter(Mandatory=$true, ParameterSetName = 'SecureString')]
       [securestring]$SecureString,
       [ValidateNotNull()]
       [string]$Description = '',
       [Parameter(Mandatory=$true)]
       [ValidateNotNull()]
       [securestring]$SecureKey
    )
    Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

    if ($PSBoundParameters.ContainsKey('Password')) {
       $SecureString = ConvertTo-SecureString $Password -AsPlainText -Force
    } elseif ($PSBoundParameters.ContainsKey('EncryptedPassword')) {
       $SecureString = ConvertTo-SecureString -String $EncryptedPassword -Key ($SecureKey | ConvertTo-PlainString | ConvertTo-ByteArray)
    }

    $NewObject = [PSCustomObject]@{PSTypeName = 'DCOpsCredential'
       HostName = $HostName
       UserName = $UserName
       Password = $SecureString
       Description = $Description
       SecureKey = $SecureKey
    }

    $NewObject = $NewObject | Add-Member -Name 'ToPSCredential' -MemberType ScriptMethod -PassThru -Value {
       if ($null -eq $this.Password) { return $null }
       $PSCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $this.UserName, $this.Password
       return $PSCredential
    }

    # We're going to override the ToString() method
    $NewObject = $NewObject | Add-Member -Name 'ToString' -MemberType ScriptMethod -PassThru -Force -Value {
       return $this.Password | ConvertTo-PlainString
    }

    $NewObject = $NewObject | Add-Member -Name 'ToEncryptedString' -MemberType ScriptMethod -PassThru -Value {
        return $this.Password | ConvertFrom-SecureString -Key ($this.SecureKey | ConvertTo-PlainString | ConvertTo-ByteArray)
    }
    return $NewObject
 }