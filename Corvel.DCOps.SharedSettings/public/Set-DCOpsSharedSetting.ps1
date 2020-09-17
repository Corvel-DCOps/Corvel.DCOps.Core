function Set-DCOpsSharedSetting {
   [CmdletBinding(SupportsShouldProcess)]
   [OutputType([System.Void])]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [ALias('Name')]
      [string]$Key,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string[]]$Value,
      [ValidateNotNullOrEmpty()]
      [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
   )

   if (-not ($SharedSettingsHash = Import-DCOpsSharedSettings -DCOpServer $DCOpServer)) {
      throw 'Unabled to get Shared Settings'
      return
   }
   if ($Value.Count -eq 1) {
   $SharedSettingsHash[$Key] = $Value[0]
   } else {
   $SharedSettingsHash[$Key] = $Value
   }
   if ($PSCmdlet.ShouldProcess('SharedSettings', 'Saving changes')) {
      Set-DCOpsJsonDataFile -Name 'sharedsettings' -DataObject $SharedSettingsHash -DCOpServer $DCOpServer
   }

}