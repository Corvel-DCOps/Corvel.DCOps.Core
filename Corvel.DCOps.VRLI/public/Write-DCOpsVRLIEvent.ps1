function Write-DCOpsVRLIEvent {
   [CmdletBinding()]
   param (
      [ValidateNotNullOrEmpty()]
      [string]$Server = (Get-DCopsServer -ServerType loginsight -Environment Production).hostname,
      [ValidateRange(1, 65535)]
      [int]$Port = 9543,
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[string]$Message,		
		[ValidateNotNullOrEmpty()]
		[System.Guid]$CorrelationID = (Get-Module Corvel.DCOPs.Logging).Guid,
		[ValidateNotNullOrEmpty()]
		[string]$ExecutionHost = $env:COMPUTERNAME,
		[ValidateNotNullOrEmpty()]
      [string]$CurrentUser = [Security.Principal.WindowsIdentity]::GetCurrent().Name,
		[ValidateNotNullOrEmpty()]
      [string]$MessageSource = (Get-PSCallStack)[0].Command, 
		[ValidateSet('VERBOSE', 'INFORMATION', 'WARNING', 'ERROR')]
		[string]$LogLevel = 'INFORMATION'           
   )
   Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

   if (-not (Test-DCOpsLoggingLevel $LogLevel (Get-DCOpsVRLILogLevel))) {
		return
	}

   Write-DCOpsInformation -Message "[$CorrelationID] Execution Started"

   $Fields = @{}
   $Fields['correlationid'] = $CorrelationID
   $Fields['executionhost'] = $ExecutionHost
   $Fields['currentuser'] = $CurrentUser
   $Fields['processid'] = $PID
   $Fields['messagesource'] = $MessageSource
   $Fields['loglevel'] = $LogLevel
   $Fields['psedition'] = $PSEdition
   $Fields['psversion'] = $PSVersionTable.PSVersion
   
   # Convert the fields from a hashtable to an array of hashtables
   $EventFields = $Fields.GetEnumerator() | ForEach-Object {[ordered]@{'name' = "$($_.Key)"; 'content' = "$($_.Value)"}}
   $EventRecord = @{text = "$Message"; fields = $EventFields}

   $ClientId = (Get-Module Corvel.DCOps.Logging).Guid.ToString()
   $URI = "https://$($Server):$($Port)/api/v1/events/ingest/$ClientId"
   $EventJson = @{events = @($EventRecord)} | ConvertTo-Json -Depth 4
   $Params = @{
      Uri = $URI
      Method = 'Post'
      ContentType = 'application/json'
      Body = $EventJson
      UseBasicParsing = $true
      Verbose = $false
   }
   if ($PSEdition -eq 'Core') {
      $Params['SkipCertificateCheck'] = $true
   } else {
      Disable-SslCertificateValidation
   }
   try {
      $RestResponse = Invoke-RestMethod @Params
      $Status = $RestResponse.status
   } catch {
      $Status = 'fail'
   }
   if ($Status -ne 'ok') {
      Write-Error 'Error posting event to Log Insight Server' 
   }

   Write-DCOpsInformation -Message "[$CorrelationID] Execution Finished"
}