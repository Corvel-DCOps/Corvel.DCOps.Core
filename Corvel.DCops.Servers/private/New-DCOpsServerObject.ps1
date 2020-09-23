function New-DCOpsServerObject {
   [CmdletBinding()]
   [OutputType('DCOpsServer')]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateScript({$_ -in (Get-DCOpsServerType)})]
      [string]$ServerType,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$DisplayName,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$HostName,
      [Parameter(Mandatory=$true)]
      [ValidateScript({$_ -in (Get-DCOpsEnvironment)})]
      [string]$Environment,
      [Parameter(Mandatory=$true)]
      [ValidateScript({$_ -in (Get-DCOpsLocation)})]
      [string]$Location,
      [System.Collections.Generic.List[string]]$IPAddress = @(),
      [hashtable]$Custom = @{}
   )
   
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
   
   $NewObject  = [PSCustomObject][ordered]@{PSTypeName = 'DCOpsServer'
      ServerType = $ServerType
      HostName = $HostName
      DisplayName = $DisplayName      
      Environment = $Environment
      Location = $Location
      IPAddress = $IPAddress
      Custom = $Custom
   }

   return $NewObject
}