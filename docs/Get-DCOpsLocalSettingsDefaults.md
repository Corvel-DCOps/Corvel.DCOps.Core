---
external help file: Corvel.DCOps.LocalSettings-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Get-DCOpsLocalSettingsDefaults.md
schema: 2.0.0
---

# Get-DCOpsLocalSettingsDefaults

## SYNOPSIS
Returns the currently system defined default values for local settings.

## SYNTAX

```
Get-DCOpsLocalSettingsDefaults [<CommonParameters>]
```

## DESCRIPTION
Some local settings have a system defined default. This command will return a hashtable of all the 
system defined keys and values.
Primarily, the system defined defaults are present to allow the Corvel.DCOps.Core module to work in 
the intended environment without having to configure anything.
The defaults can be overridded by setting the appropiate value in the local settings file.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-DCOpsLocalSettingsDefaults
Name                           Value
----                           -----
maxjsondatacacheage            900
dcopdbserver                   hbdcdcops02
dcopshost                      https://dcops.corvel.com
```

Returns the currently defined system defaults.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Collections.Hashtable

## NOTES

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Get-DCOpsLocalSettingsDefaults.md)
[Get-DCOpsLocalSetting]()
[Set-DCOpsLocalSetting]()
[Remove-DCOpsLocalSetting]()
