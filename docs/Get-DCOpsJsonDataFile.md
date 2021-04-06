---
external help file: Corvel.DCOps.JsonData-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Get-DCOpsJsonDataFile.md
schema: 2.0.0
---

# Get-DCOpsJsonDataFile

## SYNOPSIS
Retrieves a Json data file from the DCOps Host.

## SYNTAX

```
Get-DCOpsJsonDataFile [-Name] <String> [-ForceRefresh] [-AsJson] [<CommonParameters>]
```

## DESCRIPTION
Retrieves the specified Json data file from the DCOps Host. The command will return the Json data convert to a PSCustomObject 
unless the AsJson switch is set. 
If the Json data file has been retrieved recently in the current session, the data will be retrieved from the Json Data Cache unless
the ForceRefresh switch is set.
If the file is not found on the server, an empty string is returned. If an error occurs, $null is returned. Otherwise, the data is returned.
Access to the data files can be restricted to certain functions by manually editing the protectedaccess.json file on the DCOps Host.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-DCOpsJsonDataFile -Name 'somedata'
```

Retrieves the Json Data file called 'somedata.json' from the DCOps Host and returns a PSCustomObject from the data.

### Example 2
```powershell
PS C:\> Get-DCOpsJsonDataFile -Name 'somedata' -ForceRefresh -AsJson
```

Retrieves the Json Data file called 'somedata.json' from the DCOps Host and returns the raw Json data. If data is 
in the Json Data cache, it is ignored and the data if retrieved directly from the DCOps Host.

## PARAMETERS

### -AsJson
Do not convert the data to a PSCustomObject and return the raw Json.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceRefresh
Ignore the Json Data Cache and retrieve the data directly from the server.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the Json data file to retrieve.
Name can be specified with or without the .json extension. If an extension is specified,
it is removed and .json is explictily used.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

### System.String

## NOTES

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Get-DCOpsJsonDataFile.md)
[Set-DCOpsJsonDataFile]()
[about_DCopsHost]()
