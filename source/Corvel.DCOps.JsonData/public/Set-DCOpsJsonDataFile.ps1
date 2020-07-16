function Set-DCOpsJsonDataFile {
   [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
   [OutputType([System.Void])]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$Name,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [Alias('DataObject')]
      [object[]]$InputObject,
      [ValidateNotNullOrEmpty()]
      [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
   )
   $AlwaysConfirm = $false

   if (-not ($JsonDataShare = Get-DCOpsJsonDataShare -DCOpServer $DCOpServer)) {
      throw "Unable to locate DCOps Host and/or Data Share"
   }
   $FileName = [System.IO.Path]::GetFileNameWithoutExtension($Name)
   $FilePath = "$JsonDataShare\$($FileName).json"
   $BackupFilePath = "$JsonDataShare\$($FileName).bak"
   if ($FileName -eq 'dcopscredentials') {
      $AlwaysConfirm = $true
   }
   try {
      if ($PSCmdlet.ShouldProcess($FileName, 'Saving Json data file')) {
         if ($AlwaysConfirm) {
            if ($PSCmdlet.ShouldContinue("Confirm updating the shared credentials on the DCOps Server.", "Protected File")) {  
               if (Test-Path $FilePath) {
                  Copy-Item -LiteralPath $FilePath -Destination $BackupFilePath -Force
               }
               $InputObject | ConvertTo-Json | Set-Content -LiteralPath $FilePath -ErrorAction Stop
            }
         }
      }
   } catch {
      throw "Unable to create Json Data File '$($FileName).json'"
   }
   if ($CacheObject = $script:DCOpsJsonDataCache | Where-Object Name -eq $FileName) {
      $script:DCOpsJsonDataCache.Remove($CacheObject) | Out-Null
   }
}