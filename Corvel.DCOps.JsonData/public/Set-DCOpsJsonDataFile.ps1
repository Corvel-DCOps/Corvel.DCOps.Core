function Set-DCOpsJsonDataFile {
   [CmdletBinding(SupportsShouldProcess)]
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
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
   $Caller = (Get-PSCallStack)[1].Command
   $JsonDataShare = Get-DCOpsSharedSetting -Key 'jsondatashare' -DCOpServer $DCOpServer
   if (-not(Test-Path $JsonDataShare)) {
      throw "Json data share ($JsonDataShare) not accessible."
   }

   $FileName = $Name -replace '.json', ''
   if (-not (Get-DCOpsJsonDataFileAccess -Name $FileName -Caller $Caller -Access Write)) {
      throw "Permission denied to Json Data file $FileName"
      return
   }

   $FilePath = "$JsonDataShare\$($FileName).json"
   $BackupFilePath = "$JsonDataShare\$($FileName).bak"
   try {
      if ($PSCmdlet.ShouldProcess($FileName, 'Saving Json data file')) {         
         if (Test-Path $FilePath) {
            Copy-Item -LiteralPath $FilePath -Destination $BackupFilePath -Force
         }
         $InputObject | ConvertTo-Json | Set-Content -LiteralPath $FilePath -ErrorAction Stop
      }
   } catch {
      throw "Unable to create Json Data File '$($FileName).json'"
   }
   if ($CacheObject = $script:DCOpsJsonDataCache | Where-Object Name -eq $FileName) {
      $script:DCOpsJsonDataCache.Remove($CacheObject) | Out-Null
   }
}