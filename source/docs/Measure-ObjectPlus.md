---
external help file: Corvel.DCOps.Utility-help.xml
Module Name: Corvel.DCOps.Core
online version:
schema: 2.0.0
---

# Measure-ObjectPlus

## SYNOPSIS
Takes an array of objects and, in addition to the standard Measure-Object values (minimum,
maximum, sub and avearage), adds Median, Variance, StandardDeviation, Percentile10,
Percentile25, Percentile75, Percentile90, TukeysRange, and Confidence95.

## SYNTAX

```
Measure-ObjectPlus [-Data] <Array> [-Property] <String> [<CommonParameters>]
```

## DESCRIPTION
Takes an array of objects and, in addition to the standard Measure-Object values (minimum,
maximum, sub and avearage), adds Median, Variance, StandardDeviation, Percentile10,
Percentile25, Percentile75, Percentile90, TukeysRange, and Confidence95.

## EXAMPLES

### Example 1
```powershell
PS C:\> $Process = Get-Process
PS C:\> Measure-ObjectPlus -Data $Process -Property Handles


Median            : 275.5
Variance          : 1212.00012596243
StandardDeviation : 34.8137921801465
Percentile10      : 130
Percentile25      : 189
Percentile75      : 493
Percentile90      : 1036
TukeysRange       : 456
Confidence95      : 0
Count             : 218
Average           : 459.775229357798
Sum               : 100231
Maximum           : 3992
Minimum           : 0
Property          : Handles
```

The above example retrieves all of the currently running processes and then sends the array of objects to Measure-ObjectPlus
where it performs the calculations on the count of Handles.

## PARAMETERS

### -Data
An array of objects that contain a numeric property to perform the calculations against.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property
The property of the data array to perform the calcualtions against. This must be a numeric type property.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
## NOTES

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Measure-ObjectPlus.md)
[Measure-Object]()