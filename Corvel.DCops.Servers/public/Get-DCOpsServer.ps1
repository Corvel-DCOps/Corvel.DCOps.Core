function Get-DCOpsServer {
   [CmdletBinding()]
   param (
      [ValidateNotNullOrEmpty()]
      [string]$DCOpsHost = (Get-DCOpsLocalSetting -Name 'dcopshost')
   )

   return ,(Import-DCOpsServerFile -DCOpsHost $DCOpsHost)
}