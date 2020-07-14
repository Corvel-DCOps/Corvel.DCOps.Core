---
external help file: Corvel.DCOps.JsonData-help.xml
Module Name: Corvel.DCOps.Core
online version:
schema: 2.0.0
---

# Clear-DCopsJsonDataCache

## SYNOPSIS
Clears the cached Json data

## SYNTAX

```
Clear-DCopsJsonDataCache [<CommonParameters>]
```

## DESCRIPTION
When calling Get-DCOpsJsonDataFile, the json data is cached so subsequent calls can avoid another
call to the server. The maximum age of data in the cache is controlled by the 'maxjsondatacacheage' 
local setting.
Calling this cmdlet clears the existing cache so subsequent calls will retrieve a fresh copy of the 
Json data file from the DCOps Server

## EXAMPLES

### Example 1
```powershell
PS C:\> Clear-DCOpsJsonDataCache
```

After calling this cmdlet, all objects in the cache are removed and subsequent calls to Get-DCOpsJsonDataFile
will retrieve a fresh copy of the Json data file from the DCOps Server.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Clear-DCopsJsonDataCache.md)
[Get-DCOpsJsonDataCache]()
[Get-DCOpsJsonDataFile]()