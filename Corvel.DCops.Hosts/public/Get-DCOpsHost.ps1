function Get-DCOpsHost {
   [CmdletBinding()]
   param (
      [ValidateNotNullOrEmpty()]
      [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
   )

   return ,(Import-DCOpsHostFile -DCOpServer $DCOpServer)
}