---
external help file: Corvel.DCOps.SharedSettings-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Remove-DCOpsSharedSetting.md
schema: 2.0.0
---

# Remove-DCOpsSharedSetting

## SYNOPSIS
Removes a shared setting from the DCOps Server.

## SYNTAX

```
Remove-DCOpsSharedSetting [-Key] <String> [[-DCOpServer] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes a shared setting from the DCOps Server.

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-DCOpsSharedSetting -Key 'sharedkey'
```

Removes the shared setting 'sharedkey' from the DCOps Server.

## PARAMETERS

### -DCOpServer
The DCOps Server to retrieve the shared settings from. 
The default is retrieved from the 'dcopserver' local setting.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: The 'dcopserver' local setting.
Accept pipeline input: False
Accept wildcard characters: False
```

### -Key
Name of the shared setting to remove from the DCOps Server.

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
[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Remove-DCOpsSharedSetting.md)
[Get-DCOpsSharedSetting]()
[about_DCOpsServer]()
