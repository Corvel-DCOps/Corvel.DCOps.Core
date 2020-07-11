---
external help file: Corvel.DCOps.Credentials-help.xml
Module Name: Corvel.DCOps.Core
online version:
schema: 2.0.0
---

# Set-DCOpsCredential

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### Password (Default)
```
Set-DCOpsCredential -HostName <String> -UserName <String> [-Description <String>] -Password <String>
 [-DCOpServer <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PSCredential
```
Set-DCOpsCredential [-HostName <String>] [-Description <String>] -PSCredential <PSCredential>
 [-DCOpServer <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SecureString
```
Set-DCOpsCredential [-HostName <String>] [-UserName <String>] [-Description <String>]
 -SecureString <SecureString> [-DCOpServer <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DCOpsCredential
```
Set-DCOpsCredential -DCOpsCredential <Object> [-DCOpServer <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

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

### -DCOpServer
{{ Fill DCOpServer Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DCOpsCredential
{{ Fill DCOpsCredential Description }}

```yaml
Type: Object
Parameter Sets: DCOpsCredential
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
{{ Fill Description Description }}

```yaml
Type: String
Parameter Sets: Password, PSCredential, SecureString
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HostName
{{ Fill HostName Description }}

```yaml
Type: String
Parameter Sets: Password
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: PSCredential, SecureString
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PSCredential
{{ Fill PSCredential Description }}

```yaml
Type: PSCredential
Parameter Sets: PSCredential
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
{{ Fill Password Description }}

```yaml
Type: String
Parameter Sets: Password
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecureString
{{ Fill SecureString Description }}

```yaml
Type: SecureString
Parameter Sets: SecureString
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
{{ Fill UserName Description }}

```yaml
Type: String
Parameter Sets: Password
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: SecureString
Aliases:

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

### DCOpsCredential

## NOTES

## RELATED LINKS
