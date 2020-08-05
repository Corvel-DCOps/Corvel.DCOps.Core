---
external help file: Corvel.DCOps.Credentials-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Remove-DCOpsCredential.md
schema: 2.0.0
---

# Remove-DCOpsCredential

## SYNOPSIS
Remove a credential from the shared credentials on the DCOps Server.

## SYNTAX

### Search
```
Remove-DCOpsCredential -HostName <String> -UserName <String> [-DCOpServer <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### DCOpCredential
```
Remove-DCOpsCredential -DCOpsCredential <Object> [-DCOpServer <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Removes a credential from the shared credentials on the DCOps Server.
The credential to remove can be specified by the HostName and UserName parameters or by specifying a previously 
obtainted DCOpsCredential object (from Get-DCOpsCredential). 

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-DCOpsCredential -HostName 'server.domain.com' -UserName 'administrator'
```

Removes the credential matching a host name of 'server.domain.com' and a user name of 'administrator'.

### Example 1
```powershell
PS C:\> $Credential = Get-DCOpsCredential -HostName 'server.domain.com' -UserName 'administrator' 
PS C:\> Remove-DCOpsCredential -DCOpsCredential $Credential
```

First retrieves the credential matching a host name of 'server.domain.com' and a user name of 'administrator' then removes the credential.

## PARAMETERS

### -DCOpsCredential
A DCOpsCredential object (retrieved with Get-DCOpsCredential) to remove from the shared credential store.

```yaml
Type: Object
Parameter Sets: DCOpCredential
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -HostName
Host name of the credential to remove. 

```yaml
Type: String
Parameter Sets: Search
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
User name of the credential to remove

```yaml
Type: String
Parameter Sets: Search
Aliases:

Required: True
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

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Remove-DCOpsCredential.md)
[Get-DCOpsCredential]()
[about_DCOpsCredential]()
[about_DCOpsServer]()
