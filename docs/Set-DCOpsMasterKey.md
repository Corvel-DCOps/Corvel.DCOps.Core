---
external help file: Corvel.DCOps.Credentials-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Set-DCOpsMasterKey.md
schema: 2.0.0
---

# Set-DCOpsMasterKey

## SYNOPSIS
Prompts the user for the DCOps Master Key and stores it locally.

## SYNTAX

```
Set-DCOpsMasterKey [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Prompts the user for the DCOps Master Key and stores it locally.
The DCOps Master Key is used for encrypting/decrypting the shared credentials on the DCOps Host.
This command doesn't accept any parameters and will always prompt the user for the master key.
If a master key is already saved locally, the user must enter the existing key unless the Force switch is used.

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-DCOpsMasterKey
Enter the existing master key: ********************************
Enter the new master key: ********************************
Confirm the new master key: ********************************
```

Changes the DCOps Master key stored locally after prompting the user to enter the existing key.

## PARAMETERS

### -Force
If the master key is already present, the user must enter the existing key unless this switch is used.

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
Caution must be excercised when changing the DCOPs Master Key. If the key is changed without re-encrypting the shared credentials, the shared credentials
can not be decrypted.

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Set-DCOpsMasterKey.md)
[about_DCOpsHost]()
