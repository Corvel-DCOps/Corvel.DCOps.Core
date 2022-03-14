function Invoke-GnuPlot {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$true)]
		[string]$ScriptFile,
		[Parameter(Mandatory=$true)]
		[string]$DataFile,
		[Parameter(Mandatory=$true)]
		[Alias('ImageFile')]
		[string]$OutputFile,
		[guid]$CorrelationID = (New-Guid),
		[switch]$Force
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	Write-DCOpsMessage -Message 'Execution Started' -CorrelationID $CorrelationID -LogLevel VERBOSE
	if ($global:GNUPLOTINSTALLED -eq $false) {
		Write-DCOpsMessage -Message 'gnuplot not found or installed' -CorrelationID $CorrelationID -LogLevel ERROR
		return
	}

	if (-not (Test-Path $ScriptFile)) {
		Write-DCOpsMessage -Message "Script '$ScriptFile' not found" -CorrelationID $CorrelationID -LogLevel ERROR
		return
	}

	if (-not (Test-Path $DataFile)) {
		Write-DCOpsMessage -Message "Data file '$DataFile' not found" -CorrelationID $CorrelationID -LogLevel ERROR
		return
	}

	if (Test-Path $OutputFile) {
		if (-not $Force) {
			Write-DCOpsMessage -Message "Output file '$OutputFile' already exists" -CorrelationID $CorrelationID -LogLevel ERROR
			return
		}
	}

	$GnuPlotCmd = [System.Text.StringBuilder]::new()
	$GnuPlotCmd.Append('& gnuplot -e "') | Out-Null
	$GnuPlotCmd.Append("imagefile='$OutputFile'; plotdata='$DataFile';`"") | Out-Null
	$GnuPlotCmd.Append(" -c '$ScriptFile'") | Out-Null

	try {
		Invoke-Expression $GnuPlotCmd
	} catch {
		Write-DCOpsMessage -Message 'Error invoking gnuplot' -CorrelationID $CorrelationID -LogLevel ERROR
		return
	}
	Write-DCOpsMessage -Message 'Execution Finished' -CorrelationID $CorrelationID -LogLevel VERBOSE
}