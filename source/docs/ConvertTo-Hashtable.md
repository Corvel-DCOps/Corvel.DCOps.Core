---
external help file: Corvel.DCOps.Utility-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/ConvertTo-Hashtable.md
schema: 2.0.0
---

# ConvertTo-Hashtable

## SYNOPSIS
Converts an object returned by ConvertFrom-Json to a hash table.

## SYNTAX

```
ConvertTo-Hashtable [[-InputObject] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Converts an object returned by ConvertFrom-Json to a hash table.

## EXAMPLES

### Example 1
```powershell
Get-Content $env:APPDATA\Corvel.DCops\localsettings.json | ConvertFrom-Json | ConvertTo-Hashtable
Name                           Value
----                           -----
dcopsmasterkey                 ...
dcopdbserver                   HBDCDCOPS02
dcopserver                     http://hbdcdcops06.corvel.com
```

This example reads the content of a Json file, converts to a PSCustomObject using ConvertFrom-Json and then 
converts the resulting object to a hash table.

## PARAMETERS

### -InputObject
The object to convert.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

## OUTPUTS

### hashtable

## NOTES
Credit:
Adam Bertram, 4sysops.com
Retrieved from https://4sysops.com/archives/convert-json-to-a-powershell-hash-table/

## RELATED LINKS
[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/ConvertTo-Hashtable.md)

