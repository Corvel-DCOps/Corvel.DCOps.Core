function New-DCOpsJsonDataCacheObject {
    [CmdletBinding()]
    param (
       [ValidateNotNullOrEmpty()]
       [string]$Name = '',
       [ValidateNotNullOrEmpty()]
       [datetime]$LastRetrieved = 0,
       [ValidateNotNullOrEmpty()]
       [string]$RawJson
    )
    $NewObject = [PSCustomObject][ordered]@{PSTypeName = 'JsonDataCacheObject'
       Name = $Name
       LastRetrieved = $LastRetrieved
       RawJson = $RawJson
    }
    # Calculate the age of the object
    $NewObject = $NewObject | Add-Member -Name 'Age' -MemberType ScriptProperty -PassThru -Value {
       return (New-TimeSpan -Start $this.LastRetrieved).TotalSeconds
    }
    # Return the raw json converted to a PSCustomObject
    $NewObject = $NewObject | Add-Member -Name 'DataObject' -MemberType ScriptProperty -PassThru -Value {
       return ($this.RawJson | ConvertFrom-Json)
    }
    return $NewObject
 }