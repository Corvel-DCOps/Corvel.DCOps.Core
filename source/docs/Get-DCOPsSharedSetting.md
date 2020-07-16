---
external help file: Corvel.DCOps.SharedSettings-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Get-DCOPsSharedSetting.md
schema: 2.0.0
---

# Get-DCOPsSharedSetting

## SYNOPSIS
Retrieve the specified shared setting from the DCOps Server.

## SYNTAX

```
Get-DCOPsSharedSetting [[-Key] <String>] [[-DefaultValue] <String>] [-DCOpServer <String>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves the shared setting specified by Key from the DCOps Server.
If no Key is specified, all shared settings are returned, otherwise just the value of the setting is returned.
If the Key is not found then the DefaultValue is returned.
If no Key is specified, the DefaultValue parameter is ignored.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-DCOPsSharedSetting -Key 'notificationemail'
dcadmins@corvel.com
```

Retrieves the shared setting 'notificationemail' from the DCOps Server.

### Example 2
```powershell
PS C:\> Get-DCOPsSharedSetting -Key 'nokeyfound' -DefaultValue 'defaultvalue'
defaultvalue
```

Attempts to retrieve the shared setting 'nokeyfound' from the DCOps Server and returns 'defaultvalue' if it is not found.

## PARAMETERS

### -DCOpServer
The DCOps Server to retrieve the shared settings from. 
The default is retrieved from the 'dcopserver' local setting.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: The 'dcopserver' local setting
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultValue
The value to return if the Key is not found in the shared settings on the DCOps Server.

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
The Key to search for in the shared settings on the DCOps Server.
If not specified, all Key-Value pairs from the DCOps Server are returned. 

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

### System.Collections.Hashtable

### System.String

## NOTES

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Get-DCOPsSharedSetting.md)
[Set-DCOpsSharedSetting]()
[Remove-DCOpsSharedSetting]()
