function Set-DCOpsJsonDataFile {
    [CmdletBinding(SupportsShouldProcess)]
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

    if (-not ($JsonDataShare = Get-DCOpsJsonDataShare -DCOpServer $DCOpServer)) {
       throw "Unable to locate DCOps Host and/or Data Share"
    }
    $FileName = [System.IO.Path]::GetFileNameWithoutExtension($Name)
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