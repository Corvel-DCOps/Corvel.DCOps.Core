function Get-VRLIQuery {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Field,
		[ValidateSet('=', 'EQ', '!=', 'NE', '<', 'LT', '<=', 'LE', '>', 'GT', '>=', 'GE', 'CONTAINS', 'NOT_CONTAINS', 'HAS', 'NOT_HAS', 'LAST', 'EXISTS')]
		[string]$Operator,
		[ValidateNotNullOrEmpty()]
		[object]$Value
	)
	if ( $Operator -eq 'LAST' -and $Field -ne 'timestamp' ) {
		throw "Operator 'LAST' can only be used with the 'timestamp' field"
	}
	$Query = [PSCustomObject] [ordered] @{ PSTypeName = 'DCOpsVRLIQuery' 
			Field = $Field.ToLower()
			Operator = $Operator.ToUpper()
			Value = $Value
	}
	if ($Query.Operator -eq 'EXISTS') { $Query.Value = '' } else { $Query.Value = $Value }
	if ($Query.Field -eq 'timestamp' -and $Value -is [datetime]) {
		$Query.Value = ConvertTo-UnixTime -Date $Value
	}

	$Query = $Query | Add-Member -Name 'ToPath' -MemberType ScriptMethod -PassThru -Value {
		$QueryString = "/$($this.Field)/" + [uri]::EscapeDataString($this.Operator) 
		if ($this.Operator -notin ('=', '!=', '<', '<=', '>', '>=', 'EXISTS')) { $QueryString += ' ' }
		$QueryString += [uri]::EscapeDataString($this.Value)
		return $QueryString
	}
	return $Query
}