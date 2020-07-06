function Get-DCOpsJsonDataShare {
    [CmdletBinding()]
    param (
       [ValidateNotNullOrEmpty()]
       [string]$DCOpServer = (Get-DCOpsLocalSetting -Name 'dcopserver')
    )

    # First we convert the server string (which is specified as http[s]://servername:[port])
    # to a URI object. This is easier than parsing the string out to get the host name.
    # We then do a DNS query to get the host name of the server. This handles the case
    # where the server name is a CNAME record.
    # We then open a Cim session and look for a shared called 'jsondata'.
    # If it is found, we return the full UNC path to the jsondata folder.
    $URI = [uri]$DCOpServer
    if (-not ($DnsRecords = Resolve-DnsName $URI.DnsSafeHost -Type A -ErrorAction SilentlyContinue -Verbose:$false)) { return }
    $DNSHost = $DnsRecords | Where-Object QueryType -eq 'A' | Select-Object -First 1
    if (-not ($CimSession = New-CimSession -ComputerName $DNSHost.Name -ErrorAction SilentlyContinue -Verbose:$false)) { return }
    if (-not ($SmbShare = Get-SmbShare -Name 'jsondata' -CimSession $CimSession -ErrorAction SilentlyContinue )) { return }
    $JsonDataShare = "\\$($SmbShare.PSComputerName)\jsondata"
    if (Test-Path $JsonDataShare) {
       Write-Output $JsonDataShare
    }
    Remove-CimSession -CimSession $CimSession -ErrorAction SilentlyContinue -Verbose:$false -Whatif:$false
 }
