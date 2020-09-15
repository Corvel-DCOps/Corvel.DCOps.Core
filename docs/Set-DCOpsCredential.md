---
external help file: Corvel.DCOps.Credentials-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Set-DCOpsCredential.md
schema: 2.0.0
---

# Set-DCOpsCredential

## SYNOPSIS
Creates a new shared credential or updates an existing shared credential on the DCOps Server.

## SYNTAX

### Password (Default)
```
Set-DCOpsCredential -HostName <String> -UserName <String> [-Description <String>] -Password <String>
 [-DCOpServer <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PSCredential
```
Set-DCOpsCredential -HostName <String> [-Description <String>] -PSCredential <PSCredential>
 [-DCOpServer <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SecureString
```
Set-DCOpsCredential -HostName <String> -UserName <String> [-Description <String>] -SecureString <SecureString>
 [-DCOpServer <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DCOpsCredential
```
Set-DCOpsCredential -DCOpsCredential <Object> [-DCOpServer <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new shared credential or updates an existing shared credential on the DCOps Server.
The credential to create can be specified by host name, user name and password, host name, user name a SecureString 
containing the password, hostname and a PSCredential object containing the user name and password or an existing
DCOpsCredential object (retrieved by Get-DCOpsCredential).
If a match (matching host name and user name) is found, the existing credential is updated, otherwise a new credential 
is created.

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-DCOpsCredential -HostName 'server.domain.com' -UserName 'administrator' -Password 'Password' -Description 'root login for server'
```

Creates or updates the shared credential represented by the host name 'server.domain.com' and the user name 'administrator'.

## PARAMETERS

### -DCOpsCredential
A DCOpsCredential object previously obtain by calling Get-DCOpsCredential and (possibly) modified. 
Note that if the intention is to change the host name and/or user name of an existing credential, you must 
remove the existing credential and then create a new credential with updated host name and/or user name.

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

### -DCOpServer
The DCOps Server to retrieve the shared settings from. 
The default is retrieved from the 'dcopserver' local setting.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: The 'dcopserver' local setting.
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
A description for the shared credential.

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
The host name of the shared credential to create or update.
Note that the combination of HostName and UserName is the 'primary' key for shared credentials.

```yaml
Type: String
Parameter Sets: Password, PSCredential, SecureString
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
The password (in plain text) of the shared credential to create or update. This will be encrypted using the DCOpsMaster Key.

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

### -PSCredential
A PSCrednetial object that contains the user name and password of the shared credential to create or update.

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

### -SecureString
A SecureString that contains the password of the shared credential to create or update.

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
The user name of the shared credential to create or update.
Note that the combination of HostName and UserName is the 'primary' key for shared credentials.

```yaml
Type: String
Parameter Sets: Password, SecureString
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

### DCOpsCredential

## NOTES

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Set-DCOpsCredential.md)
[Get-DCOpsCredential]()
[Remove-DCopsCredential]()
[about_DCOpsCredential]()
[about_DCOpsServer]()