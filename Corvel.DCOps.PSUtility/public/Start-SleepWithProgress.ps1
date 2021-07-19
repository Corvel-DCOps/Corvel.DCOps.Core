Function Start-SleepWithProgress {
	[CmdletBinding()]
	param (
		[ValidateRange(1,[int]::MaxValue)]
		[int]$WaitSeconds=60,
		[ValidateRange(1,[int]::MaxValue)]
		[ValidateScript({
			if ($_ -ge $WaitSeconds) {
				Throw ("ProgressSeconds must be less than WaitSeconds")
			} else {
				$True
			}
		})]
		[int]$ProgressSeconds=10,
		[char]$ProgressChar='.',
		[System.ConsoleColor]$ForegroundColor = [System.ConsoleColor]::Yellow,
		[System.ConsoleColor]$BackgroundColor = [System.ConsoleColor]::DarkCyan,
		[switch]$NoNewLine
	)

	$ElapsedSeconds = 0
	$TimeToSleep = [Math]::Min($WaitSeconds, $ProgressSeconds)

	while ($true) {
		Write-Host $ProgressChar -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -NoNewLine
		Start-Sleep -Seconds $TimeToSleep
		$ElapsedSeconds+=$TimeToSleep
		if ($ElapsedSeconds -ge $WaitSeconds) {
			if ($NoNewLine -eq $False) {
				Write-Host ""
			}
			return
		}
		$TimeToSleep = [Math]::Min($ProgressSeconds, ($WaitSeconds - $ElapsedSeconds))
	}
}