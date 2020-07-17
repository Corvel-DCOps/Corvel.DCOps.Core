---
external help file: Corvel.DCOps.Utility-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/ConvertFrom-EpochTime.md
schema: 2.0.0
---

# ConvertFrom-EpochTime

## SYNOPSIS
Converts an integer value representing an epoch (linux) timestamp to a DateTime value.

## SYNTAX

```
ConvertFrom-EpochTime [-EpochTime] <Int64> [-ToLocalTime] [<CommonParameters>]
```

## DESCRIPTION
Converts an integer value representing an epoch (linux) timestamp to a DateTime value.

## EXAMPLES

### Example 1
```powershell
PS C:\> -106851600000 | ConvertFrom-EpochTime

Saturday, August 13, 1966 7:00:00 AM
```

Takes an integer value representing an epoch (linux) timestamp and converts it to a DateTime value.

## PARAMETERS

### -EpochTime
An integer representing an epoch time.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ToLocalTime
Return the DateTime object in local time.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int64

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/ConvertFrom-EpochTime.md)
[ConvertTo-EpochTime]()
