function Set-DCOpsLogPath {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[string]$Path
	)

	if (-not (Test-Path $Path -PathType Container -IsValid)) {
		throw "'$Path' is not a valid path."
		return
	}

	if (-not (Test-Path $Path -PathType Container)) {
		$NewPath = New-Item -Path $Path -ItemType Directory -Force -ErrorAction SilentlyContinue
		if ($null -eq $NewPath) {
			throw "Failed to create path '$Path'."
			return
		}
	}
	Set-DCOpsLocalSetting -Key 'dcopslogpath' -Value (Resolve-Path $Path).Path

}