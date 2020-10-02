function Set-DCOpsServer {
   [CmdletBinding(SupportsShouldProcess)]
   [OutputType('DCOpsServer')]
   param (
      [Parameter(Mandatory=$true, ParameterSetName='Object', ValueFromPipeline)]
      [PSTypeName('DCOpsServer')]$DCOpsServer,
      [Parameter(Mandatory=$true, ParameterSetName='Details')]
      [ValidateScript({$_ -in (Get-DCOpsServerType)})]
      [string]$ServerType,
      [Parameter(Mandatory=$true, ParameterSetName='Details')]
      [string]$HostName,      
      [Parameter(Mandatory=$true, ParameterSetName='Details')]
      [string]$DisplayName,
      [Parameter(Mandatory=$true, ParameterSetName='Details')]
      [ValidateScript({$_ -in (Get-DCOpsEnvironment)})]
      [string]$Environment,
      [Parameter(Mandatory=$true, ParameterSetName='Details')]
      [ValidateScript({$_ -in (Get-DCOpsLocation)})]
      [string]$Location,
      [Parameter(ParameterSetName='Details')]
      [System.Collections.Generic.List[string]]$IPAddress = @(),
      [Parameter(ParameterSetName='Details')]
      [hashtable]$Custom = @{},
      [ValidateNotNullOrEmpty()]
      [string]$DCOpsHost = (Get-DCOpsLocalSetting -Name 'dcopshost')
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

   $DCOpsServers = Import-DCOpsServerFile -DCOpsHost $DCOpsHost
   
   if (-not ($PSBoundParameters.ContainsKey('DCOpsServer'))) {
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
         $DCOpsServer = New-DCOpsServerObject @Params
      } catch {
         return
      }
   }

   # See if we already have the object
   $SearchObj = $DCOpsServers | Where-Object {$_.ServerType -eq $DCOpsServer.ServerType -and $_.HostName -eq $DCOpsServer.HostName}
   if ($SearchObj) {
      $DCOpsServers.Remove($SearchObj) | Out-Null
   }
   if ($PSCmdlet.ShouldProcess($DCOpsServer.DisplayName, "Updating servers")) {
      $DCOpsServers.Add($DCOpsServer) | Out-Null
      Set-DCOpsJsonDataFile -Name 'servers' -InputObject $DCOpsServers -DCOpsHost $DCOpsHost
   }
   return $DCOpsServer
}