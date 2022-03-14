function Connect-VRLIServer {
	[CmdletBinding()]
	param (
      [ValidateNotNullOrEmpty()]
      [string]$Server = (Get-DCopsServer -ServerType loginsight -Environment Production).hostname,
      [ValidateRange(1, 65535)]
      [int]$Port = 9543,
		[ValidateNotNullOrEmpty()]
		[PSCredential]$Credential = (Get-DCOpsCredential -HostName $Server -AsPSCredential | Select-Object -First 1),
		[ValidateNotNullOrEmpty()]
		[guid]$CorrelationID = (New-Guid)
	)
	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
	Write-DCOpsMessage -Message 'Execution Started' -LogLevel VERBOSE -CorrelationID $CorrelationID

	$JsonCreds = @{
		provider = 'Local'
		username = $Credential.UserName
		password = $Credential.GetNetworkCredential().Password
	} | ConvertTo-Json

	$Params = @{
		Uri = "https://${Server}:${Port}/api/v1/sessions"
		Method = 'Post'
		Body = $JsonCreds
		ContentType = 'application/json'
		UseBasicParsing = $true
		ErrorAction = 'SilentlyContinue'
	}
	if (-not $PSEdition -or $PSEdition -eq 'Desktop') {
		Disable-SslCertificateValidation
	} else {
		$Params['SkipCertificateCheck'] = $true
	}
	try {
		$Response = Invoke-RestMethod @Params
	} catch {
		Write-DCOpsMessage -Message $_ -LogLevel ERROR -CorrelationID $CorrelationID
	}

	Write-DCOpsMessage -Message 'Execution Finished' -LogLevel VERBOSE -CorrelationID $CorrelationID
	if ($Response) {
		return $Response.sessionId
	}
}