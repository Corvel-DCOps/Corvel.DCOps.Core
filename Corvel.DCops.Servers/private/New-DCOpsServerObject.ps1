function New-DCOpsServerObject {
   [CmdletBinding()]
   [OutputType('DCOpsServer')]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$ServerType,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$DisplayName,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$HostName,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [ValidateSet('Production', 'Lab', 'Corporate')]
      [string]$Environment,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [ValidateSet('HBDC', 'LVDC', 'LBDC')]
      [string]$Location,
      [ValidateNotNullOrEmpty()]
      [System.Collections.Generic.List[string]]$IPAddress = @(),
      [ValidateNotNullOrEmpty()]
      [hashtable]$Custom = @{}
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
   
   $NewObject  = [PSCustomObject][ordered]@{PSTypeName = 'DCOpsServer'
      ServerType = $ServerType
      DisplayName = $DisplayName
      HostName = $HostName
      Environment = $Environment
      Location = $Location
      IPAddress = $IPAddress
      Custom = $Custom
   }

   return $NewObject
}