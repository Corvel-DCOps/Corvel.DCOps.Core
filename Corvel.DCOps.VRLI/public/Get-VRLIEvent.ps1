function Get-VRLIEvent {
	[CmdletBinding()]
	param (
		[ValidateNotNullOrEmpty()]
		[PSTypeNameAttribute('DCOpsVRLIQuery')]
		[object[]]$Query,
		[ValidateSet('ASC', 'DESC')]
		[string]$Sort = 'DESC',
		[ValidateScript({ $_ -gt 0 })]
		[int]$Limit = 100,
		[ValidateScript({ $_ -gt 0 })]
		[int]$TimeoutSeconds = 30,
		[ValidateSet('DEFAULT', 'SIMPLE')]
		[string]$View = 'SIMPLE',
		[string[]]$ContentPackField,
      [ValidateNotNullOrEmpty()]
      [string]$Server = (Get-DCopsServer -ServerType loginsight -Environment Production).hostname,
      [ValidateRange(1, 65535)]
      [int]$Port = 9543,
		[ValidateNotNullOrEmpty()]
		[PSCredential]$Credential = (Get-DCOpsCredential -HostName $Server -AsPSCredential | Select-Object -First 1),
		[ValidateNotNullOrEmpty()]
		[guid]$CorrelationID =  (Get-Module Corvel.DCOPs.Core).Guid
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	Write-DCOpsMessage -Message 'Execution Started' -LogLevel VERBOSE -CorrelationID $CorrelationID -NoVRLI

	$Authorization = Connect-VRLIServer -Server $Server -Port $Port -Credential $Credential -CorrelationID $CorrelationID
	if ($Authorization.Length -eq 0 ) { throw "Unable to connect to server '$Server'" }

	$BaseURI = "https://${Server}:${Port}/api/v1"
	$Headers = @{
		Authorization = "Bearer $Authorization"
		Accept = 'application/json'
		'Content-Type' = 'application/json'
	}

	$QueryString = '/events'
	foreach ($QueryElement in $Query) { $QueryString += $QueryElement.ToPath() }
	$QueryParameters = "?view=$VIEW&limit=$Limit&timeout=$($TimeoutSeconds * 1000)&order-by-direction=$Sort"
	foreach ($Field in $ContentPackField) { $QueryParameters += "&content-pack-fields=$Field" }
	$Params = @{
		URI = "$BaseURI$QueryString$QueryParameters"
		Method = 'GET'
		Headers = $Headers 
		UseBasicParsing = $true
		ErrorAction = 'SilentlyContinue'
	}
	if ($PSEdition -eq 'Core') {
		$Params['SkipCertificateCheck'] = $true
	} else {
		Disable-SslCertificateValidation
	}

	try {
		$Response = Invoke-RestMethod @Params
	} catch {
		Write-DCOpsMessage -Message $_ -LogLevel ERROR -CorrelationID $CorrelationID -NoVRLI 
	}

	Write-DCOpsMessage -Message 'Execution Finished' -LogLevel VERBOSE -CorrelationID $CorrelationID -NoVRLI
	return $Response
}