---
external help file: Corvel.DCOps.Utility-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/ConvertTo-ByteArray.md
schema: 2.0.0
---

# ConvertTo-ByteArray

## SYNOPSIS
Encodes all the characters in the specified string into a sequence of bytes using ASCII encoding.

## SYNTAX

```
ConvertTo-ByteArray [-String] <String> [<CommonParameters>]
```

## DESCRIPTION
Encodes all the characters in the specified string into a sequence of bytes using ASCII encoding.
Wrapper for call to [System.Text.Encoding]::ASCII.GetBytes.

## EXAMPLES

### Example 1
```powershell
PS C:\> ConvertTo-ByteArray -String 'somestring'
115
111
109
101
115
116
114
105
110
103
```

This command returns a byte array containing the results of encoding the specified set of characters.

## PARAMETERS

### -String
The String to be encoded.

```yaml
Type: String
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

### System.String

## OUTPUTS

### System.Byte[]

## NOTES

## RELATED LINKS
[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/ConvertTo-ByteArray.md)