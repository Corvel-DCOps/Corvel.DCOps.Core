function New-DCOpsScriptObject {
	[CmdletBinding(DefaultParameterSetName = 'Details')]
	param (
		[Parameter(ParameterSetName='Details', Position = 0)]
		[string]$Name = $null,
		[Parameter(ParameterSetName='Details', Position = 1)]
		[System.Version]$Version = $null,
		[Parameter(ParameterSetName='ScriptInfo')]
		[hashtable]$ScriptInfo
	)
	if ($PSBoundParameters.ContainsKey('ScriptInfo')) {
		$NewObject = [PSCustomObject][ordered]@{PSTypeName = 'DCOpsScript'
			Name = $ScriptInfo['Name']
			Version = [System.Version]$ScriptInfo['Version']
		}	
	} else {
		$NewObject = [PSCustomObject][ordered]@{PSTypeName = 'DCOpsScript'
			Name = $Name
			Version = $Version
		}
	}
	$NewObject | Add-Member -Name 'ToHashTable' -MemberType ScriptMethod -Value {
		return @{Name = $this.Name; Version = [string]$this.Version}
	}

	$NewObject | Add-Member -Name 'ToString' -MemberType ScriptMethod -Force -Value {
		"$($this.Name) v$($this.Version.ToString())"
	}
	return $NewObject
}