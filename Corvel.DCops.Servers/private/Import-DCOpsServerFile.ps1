function Import-DCOpsServerFile {
   [CmdletBinding()]
   [OutputType([System.Collections.Generic.List[PSCustomObject]])]
   param (
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

   $DCOpsServers = [System.Collections.Generic.List[PSCustomObject]]@()

   $Servers = Get-DCOpsJsonDataFile -Name 'servers'
   if ($null -eq $Servers) {
      throw 'Unable to load servers file.'
      return
   }
   foreach ($Server in $Servers) {
      $Params = @{
         ServerType = $Server.ServerType
         HostName = $Server.HostName
         DisplayName = $Server.DisplayName
         Environment = $Server.Environment
         Location = $Server.Location
      }
      if ($Server.IPAddress) { $Params['IPAddress'] = $Server.IPAddress }  
      $Custom = $Server.Custom | ConvertTo-Hashtable 
      if ($Custom.Count -gt 0) { $Params['Custom'] = $Custom }
      try {
         $DCOpsServer = New-DCopsServerObject @Params
         $DCOpsServers.Add($DCOpsServer) | Out-Null
      } catch {
         Write-Warning "Invalid host object in data file: $($Server.DisplayName)"
      }
   }
   return ,$DCOpsServers

}