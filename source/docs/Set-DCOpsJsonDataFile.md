---
external help file: Corvel.DCOps.JsonData-help.xml
Module Name: Corvel.DCOps.Core
online version: https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Set-DCOpsJsonDataFile.md
schema: 2.0.0
---

# Set-DCOpsJsonDataFile

## SYNOPSIS
Updates a Json Data file on the DCOps Server.

## SYNTAX

```
Set-DCOpsJsonDataFile [-Name] <String> [-InputObject] <Object[]> [[-DCOpServer] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates a Json Data file on the DCOps Server.
The command is primarily intended to be used by other functions to update their specific data files after any
processing of the data that needs to occur before saving the data. For example, the DCOpsSharedSetting and DCOpsCredential
commands use this function after domain specific processing to update the back end data files.

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-DCOpsJsonDataFile -Name 'jsondatafile' -InputObject $Data
```

Creates or updates a data file called 'jsondatafile.json' with the Json representation of the data in the $Data on the DCOps Server.

## PARAMETERS

### -DCOpServer
The DCOps Server to retrieve the shared settings from. 
The default is retrieved from the 'dcopserver' local setting.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: The 'dcopserver' local setting.
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Data to be saved to the data file. This object is converted to Json before saving.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: DataObject

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the Json data file to retrieve.
Name can be specified with or without the .json extension. If an extension is specified,
it is removed and .json is explictily used.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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

[Online Version](https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/Set-DCOpsJsonDataFile.md)
[Get-DCOpsJsonDataFile]()
[about_DCOpsServer]
