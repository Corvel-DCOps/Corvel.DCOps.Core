---
external help file: Corvel.DCOps.LocalSettings-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Set-DCOpsLocalSetting.md
schema: 2.0.0
---

# Set-DCOpsLocalSetting

## SYNOPSIS
Updates or creates a setting (Key-Value pair) in the local settings file.

## SYNTAX

```
Set-DCOpsLocalSetting [-Key] <String> [-Value] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates or creates the local setting specified by Key with the Value.
The local settings file stored at %APPDATA%\Corvel.DCOps\localsettings.json.

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-DCOpsLocalSetting -Key 'mykey' -Value 'My Value'
```

Updates or creates a new local setting with a key of 'mykey' and the value 'My Value'.

## PARAMETERS

### -Key
The name of the local setting to create or update.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
The value of the setting.

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

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Set-DCOpsLocalSetting.md)
[Get-DCOpsLocalSetting]()
[Remove-DCOpsLocalSetting]()
