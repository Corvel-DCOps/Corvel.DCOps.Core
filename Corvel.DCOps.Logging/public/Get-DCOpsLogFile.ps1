function Get-DCOpsLogFile {
	[CmdletBinding()]
	param (
		[switch]$Create
	)

	$LogPath = Get-DCOpsLogPath
	$LogFile = "Corvel.DCOps-$(Get-Date -Format 'yyyyMMdd').log"
	$FullLogPath = Join-Path $LogPath $LogFile

	if ($Create -and -not (Test-Path -Path $FullLogPath -PathType Leaf)) {
		New-Item -Path $FullLogPath -ItemType File -Force -ErrorAction SilentlyContinue | Out-Null
	}

	return $FullLogPath
}