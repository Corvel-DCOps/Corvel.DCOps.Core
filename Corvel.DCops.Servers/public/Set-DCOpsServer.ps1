function Set-DCOpsServer {
   [CmdletBinding()]
   [OutputType([System.Collections.Generic.List[PSCustomObject]])]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateScript({$_ -in (Get-DCOpsServerType)})]
      [string]$ServerType,
      [Parameter(Mandatory=$true, ParameterSetName='Details')]
      [string]$HostName,      
      [Parameter(Mandatory=$true)]
      [string]$DisplayName,
      [Parameter(Mandatory=$true)]
      [ValidateScript({$_ -in (Get-DCOpsEnvironment)})]
      [string]$Environment,
      [Parameter(Mandatory=$true)]
      [ValidateScript({$_ -in (Get-DCOpsLocation)})]
      [string]$Location,
      [System.Collections.Generic.List[string]]$IPAddress = @(),
      [hashtable]$Custom = @{},
      [ValidateNotNullOrEmpty()]
      [string]$DCOpsHost = (Get-DCOpsLocalSetting -Name 'dcopshost')
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

   $DCOpsServers = Import-DCOpsServerFile -DCOpsHost $DCOpsHost
   
   $Params = @{
      ServerType = $ServerType
      HostName = $HostName
      DisplayName = $DisplayName
      Environment = $Environment
      Location = $Location
   }
   if ($PSBoundParameters.ContainsKey('IPAddress')) { $Params['IPAddress'] = $IPAddress }  
   if ($PSBoundParameters.ContainsKey('Custom')) { $Params['Custom'] = $Custom }
   try {
      $ServerObject = New-DCOpsServerObject @Params
   } catch {
      return
   }
   
   return $ServerObject
}