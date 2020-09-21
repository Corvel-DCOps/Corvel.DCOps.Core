function Import-DCOpsHostFile {
   [CmdletBinding()]
   [OutputType([System.Collections.Generic.List[PSCustomObject]])]
   param (
      [ValidateNotNullOrEmpty()]
      [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

   $DCOpsHosts = [System.Collections.Generic.List[PSCustomObject]]@()

   $Hosts = Get-DCOpsJsonDataFile -Name 'hosts' -DCOpServer $DCOpServer
   if ($null -eq $Hosts) {
      throw 'Unable to load hosts file.'
      return
   }
   foreach ($DCOpHost in $Hosts) {
      $Params = @{
         ServerType = $DCOpHost.ServerType
         DisplayName = $DCOpHost.DisplayName
         HostName = $DCOpHost.HostName
         Environment = $DCOpHost.Environment
         Location = $DCOpHost.Location
      }
      if ($DCOpHost.IPAddress) { $Params['IPAddress'] = $DCOpHost.IPAddress }  
      $Custom = $DCOpHost.Custom | ConvertTo-Hashtable 
      if ($Custom.Count -gt 0) { $Params['Custom'] = $Custom }
      try {
         $HostObj = New-DCopsHostObject @Params
         $DCOpsHosts += $HostObj
      } catch {
         Write-Warning "Invalid host object in data file: $($Server.DisplayName)"
      }
   }
   return ,$DCOpsHosts

}