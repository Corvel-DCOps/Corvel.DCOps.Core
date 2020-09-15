---
external help file: Corvel.DCOps.Credentials-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Get-DCOpsMasterKey.md
schema: 2.0.0
---

# Get-DCOpsMasterKey

## SYNOPSIS
Retrieves the current DCOps Master Key used for decrypting credentials on the DCOps Server. 

## SYNTAX

```
Get-DCOpsMasterKey [<CommonParameters>]
```

## DESCRIPTION
The DCOps Master Key is used for encrypting/decrypting credentials stored on the DCOps Server. 
If the the master key is not present, credentials can not be retreived. 

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-DCOpsMasterKey
System.Security.SecureString
```

Returns the currently set DCOps Master Key.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Security.SecureString

## NOTES

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Get-DCOpsMasterKey.md)
[Set-DCOpsMasterKey]()
