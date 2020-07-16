---
external help file: Corvel.DCOps.JsonData-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Get-DCOpsJsonDataCache.md
schema: 2.0.0
---

# Get-DCOpsJsonDataCache

## SYNOPSIS
Retrieves the cached Json data.

## SYNTAX

```
Get-DCOpsJsonDataCache [<CommonParameters>]
```

## DESCRIPTION
Retrieves the cached Json data.
When calling Get-DCOpsJsonDataFile, the json data is cached so subsequent calls can avoid another
call to the server. The maximum age of data in the cache is controlled by the 'maxjsondatacacheage' 
local setting.
The cmdlet returns a JsonDataCacheObject that consists of the following properties:
- Name <string> The name of the Json data file.
- LastRetrieved <datetime> The time the Json data file was retrieved from the server.
- RawJson <string> The Json data as it was retrieved from the server.
- Age <double> The age of the cached Json data in seconds.
- DataObject <object> The Json data converted to a PowerShell object. 

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-DCOpsJsonDataCache
Name             LastRetrieved                 Age RawJson
----             -------------                 --- -------
sharedsettings   7/14/2020 12:39:52 PM  41.3066142 <string>
```

Returns the current contents of the Json Data Cache.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### Zero or more JsonDataCacheObjects.

## NOTES
The DataObject property is the equivelant of calling $CacheObject.RawJson | ConvertFrom-Json.

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Get-DCOpsJsonDataCache.md)
[Clear-DCOpsJsonDataCache]()
[Get-DCOpsJsonDataFile]()
[about_DCOpsServer]()
