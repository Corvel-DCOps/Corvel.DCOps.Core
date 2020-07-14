---
external help file: Corvel.DCOps.Credentials-help.xml
Module Name: Corvel.DCOps.Core
online version:
schema: 2.0.0
---

# Get-DCOpsCredential

## SYNOPSIS
Retrieves shared credentials from the DCOps Server.

## SYNTAX

```
Get-DCOpsCredential [[-HostName] <String>] [[-UserName] <String>] [[-Description] <String>]
 [[-DCOpServer] <String>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves shared credentials from the DCOps Server corresponding to the filter criteria define
by the HostName, UserName and Description parameters. All three parameters support wildcards.
If no criteria is specified, all shared credentials are returned.
If no matches are found, Null is returned.
If DCOpsServer is not specified, the default from the 'dcopserver' local setting. is used.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-DCOpsCredential -HostName 'hbdcdcops*'
```

Retrieves all credentials where the HostName begins with 'hbdcdcops'. 

## PARAMETERS

### -DCOpServer
The DCOps Server to retrieve the credentials from. 
The default is retrieved from the 'dcopserver' local setting.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: The 'dcopserver' local setting
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Specifies the description of the credential you wish to retrieve.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -HostName
Specifies the host name of the credential you wish to retrieve.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -UserName
Specifies the user name of the credential you wish to retrieve.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### Zero or more DCOpsCredential objects.

## NOTES

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Get-DCOpsCredential.md)
[Set-DCOpsCredential]()
[Remove-DCOpsCredential]()
[about_DCOpsCredential]()
[about-DCOpsServer]()