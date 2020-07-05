$script:MasterKeyHistory = "$env:APPDATA\Corvel.DCOps\masterkey.history"

#region LoadScripts
. "$PSScriptRoot\loadfunctions.ps1"
Load-Function $MyInvocation.MyCommand.Path
#endregion

# if (-not (Get-DCOpsLocalSetting -Key 'dcopsmasterkey')) { Write-Warning "DCOps Master Key not found." }