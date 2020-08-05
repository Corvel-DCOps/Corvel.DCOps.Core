---
external help file: Corvel.DCOps.Utility-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/ConvertTo-Base64Credential.md
schema: 2.0.0
---

# ConvertTo-Base64Credential

## SYNOPSIS
Takes a user name and password or a PSCredential object and converts them to a Base64 encoded string.

## SYNTAX

### StringPassword (Default)
```
ConvertTo-Base64Credential [-UserName] <String> [-Password] <String> [<CommonParameters>]
```

### PSCredential
```
ConvertTo-Base64Credential -PSCredential <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
Takes a user name and password or a PSCredential object and converts them to a Base64 encoded string.
Useful for creating authorization headers for web requests.

## EXAMPLES

### Example 1
```powershell
PS C:\> $EncodedCredential = ConvertTo-Base64Credential -UserName 'root' -Password '@password1'
PS C:\> $Header = @{'Authorization' = "Base $EncodedCredentials"}
PS C:\> $Header
Name                           Value
----                           -----
Authorization                  Base cm9vdDpAcGFzc3dvcmQx
```

The above example takes the supplied user name and password and encodes it. It then uses the encoded credentials to create
an Authorization header suitable for calls to a web server.

## PARAMETERS

### -Password
The password as plain text to be encoded.

```yaml
Type: String
Parameter Sets: StringPassword
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PSCredential
A PowerShell PSCredential object to encode.

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

### -UserName
The user name to be encoded.

```yaml
Type: String
Parameter Sets: StringPassword
Aliases: User

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/ConvertTo-Base64Credential.md)