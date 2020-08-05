---
external help file: Corvel.DCOps.Utility-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/ConvertTo-PlainString.md
schema: 2.0.0
---

# ConvertTo-PlainString

## SYNOPSIS
Takes a SecureString and converts it to plain text.

## SYNTAX

```
ConvertTo-PlainString [-SecureString] <SecureString> [<CommonParameters>]
```

## DESCRIPTION
Takes a SecureString and converts it to plain text.
Useful when you need the plain text version of a password.

## EXAMPLES

### Example 1
```powershell
PS C:\> $SecurePassword = Read-Host -Prompt 'Enter password' -AsSecureString
Enter password: ***********
PS C:\> ConvertTo-PlainString -SecureString $SecurePassword
password123
```

The above example prompts the user to enter a password using Read-Host with the AsSecureString parameter which will return a secure string encrypting the password. Then, ConvertTo-PlainString converts the secured password back to a unencrypted string.

## PARAMETERS

### -SecureString
The SecureString to be unencrypted.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Security.SecureString

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/ConvertTo-PlainString.md)
