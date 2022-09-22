function Get-Percentile {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[double[]]$Dataset,
		[Parameter(Mandatory = $true)]
		[ValidateRange(0, 100)]
		[double]$Percentile
	)

	# Make sure the dataset is sorted
	$Dataset = $Dataset | Sort-Object

	[int]$Count = $Dataset.Length

	[int]$Ordinal = [System.Math]::Floor([double]($Count * ($Percentile / 100)))
	return $Dataset[$Ordinal]
	
}