---
external help file: Corvel.DCOps.SharedSettings-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Set-DCOpsSharedSetting.md
schema: 2.0.0
---

# Set-DCOpsSharedSetting

## SYNOPSIS
Updates or creates a shared setting on the DCOps Host. 

## SYNTAX

```
Set-DCOpsSharedSetting [-Key] <String> [-Value] <String[]> [[-DCOpServer] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates or creates a shared setting on the DCOps Host.

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-DCOpsSharedSetting -Key 'sharedsetting' -Value 'new value'
```

Creates a new shared setting (if 'sharedsetting' doesn't exist) or updates an existing shared setting (if 'sharedsetting' already exists) with 'new value'

## PARAMETERS

### -DCOpsHost
The DCOps Host to retrieve the shared settings from. 
The default is retrieved from the 'dcopshost' local setting.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: The 'dcopshost' local setting.
Accept pipeline input: False
Accept wildcard characters: False
```

### -Key
The name of the shared setting to update (if it already exists) or to create.

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
The value of the shared setting.

```yaml
Type: String[]
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

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Set-DCOpsSharedSetting.md)
[Get-DCOpsSharedSetting]()
[about_DCOpsHost]