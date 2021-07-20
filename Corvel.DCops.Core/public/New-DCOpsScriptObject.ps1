function New-DCOpsScriptObject {
	[CmdletBinding(DefaultParameterSetName = 'Details')]
	param (
		[Parameter(ParameterSetName='Details', Position = 0)]
		[string]$ScriptName = $null,
		[Parameter(ParameterSetName='Details', Position = 1)]
		[System.Version]$ScriptVersion = $null,
		[Parameter(ParameterSetName='ScriptInfo')]
		[hashtable]$ScriptInfo
	)
	if ($PSBoundParameters.ContainsKey('ScriptInfo')) {
		$NewObject = [PSCustomObject][ordered]@{PSTypeName = 'DCOpsScript'
			ScriptName = $ScriptInfo['ScriptName']
			ScriptVersion = [System.Version]$ScriptInfo['ScriptVersion']
		}	
	} else {
		$NewObject = [PSCustomObject][ordered]@{PSTypeName = 'DCOpsScript'
			ScriptName = $ScriptName
			ScriptVersion = $ScriptVersion
		}
	}
	$NewObject | Add-Member -Name 'ToHashTable' -MemberType ScriptMethod -Value {
		return @{ScriptName = $this.ScriptName; ScriptVersion = [string]$this.ScriptVersion}
	}

	$NewObject | Add-Member -Name 'AsString' -MemberType ScriptProperty -Value {
		"$($this.ScriptName) v$($this.ScriptVersion.ToString())"
	}
	return $NewObject
}