---
external help file: Corvel.DCOps.LocalSettings-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Get-DCOpsLocalSetting.md
schema: 2.0.0
---

# Get-DCOpsLocalSetting

## SYNOPSIS
Retrieve the specified local setting.

## SYNTAX

```
Get-DCOpsLocalSetting [[-Key] <String>] [[-DefaultValue] <String>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves the local setting specified by Key from the local settings file stored at %APPDATA%\Corvel.DCOps\localsettings.json.
If no Key is specified, all local settings are returned, otherwise just the value of the setting is returned.
If the Key is not found then the DefaultValue is returned or, in for some keys, the System Default Value is returned.
If no Key is specified, the DefaultValue parameter is ignored.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-DCOpsLocalSetting -Key 'dcopserver'
https://dcops.corvel.com
```

Returns the current value of the 'dcopserver' local setting.

### Example 2
```powershell
PS C:\> Get-DCOpsLocalSetting -Key 'missingvalue' -DefaultValue 'defaultvalue'
defaultvalue
```

If 'missingvalue' is not a key in the local settings file, returns the DefaultValue 'defaultvalue'.

### Example 3
```powershell
PS C:\> Get-DCOpsLocalSetting 
Name                           Value
----                           -----
dcopdbserver                   HBDCDCOPS02
dcopserver                     http://hbdcdcops06.corvel.com
```

Returns a hashtable of all the Key-Value pairs in the local settings file. 

## PARAMETERS

### -DefaultValue
The value to return if the Key is not found in the local settings file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Key
The Key to search for in the local settings file.
If not specified, all Key-Value pairs in the local settings are returned. 

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: False
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

### System.String

## NOTES

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Get-DCOpsLocalSetting.md)
[Set-DCOpsLocalSetting]()
[Remove-DCOpsLocalSettings]()
[Get-DCOpsLocalSettingsDefaults]()
