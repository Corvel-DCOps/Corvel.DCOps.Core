---
external help file: Corvel.DCOps.Utility-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Disable-SslCertificateValidation.md
schema: 2.0.0
---

# Disable-SslCertificateValidation

## SYNOPSIS
Disable Ssl certificate validation for the current session.

## SYNTAX

```
Disable-SslCertificateValidation [<CommonParameters>]
```

## DESCRIPTION
Disable Ssl certificate validation for the current session. Used for accessing systems 
that are using self-signed certificates.
This should be avoided if possible. 

## EXAMPLES

### Example 1
```powershell
PS C:\> $Results = Invoke-RestMethod -Uri $URI -Method Get -Headers $headers
Invoke-RestMethod : The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel.
At line:1 char:12
(truncated)...

PS C:\> Disable-SslCertificateValidation
PS C:\> $Results = Invoke-RestMethod -Uri $URI -Method Get -Headers $headers
```

In the above example, first a call is made to Invoke-RestMethod where the URI points to a system that is using a self-signed
certificate and the request fails.
After calling Disable-SslCertificateValidation, the first call is repeated and the call succeeds. 

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Disable-SslCertificateValidation.md)
