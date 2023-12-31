# ConvertTo-PSTerraformLikeAction

## SYNOPSIS
ConvertTo-PSTerraformLikeAction will convert a PowerShell command to a YAML configuration file that can be used with PSTerraformLike

Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and declarative manner.
        Terraform is not required to use this module.

## SYNTAX
```
ConvertTo-PSTerraformLikeAction [[-Command] <String>] [-Compress] [-Walkthrough] [<CommonParameters>]
```

## DESCRIPTION
ConvertTo-PSTerraformLikeAction will convert a PowerShell command to a YAML configuration file that can be used with 
PSTerraformLike

Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and 
declarative manner.
        Terraform is not required to use this module.

## EXAMPLES

### EXAMPLE 1
 ``` 
 Command: ConvertTo-PSTerraformLikeAction -Command 'Start-Service'
 ``` 
 ```yam 
 Description: This will convert the Start-Service command to a YAML configuration file
Notes: All Action commands need to be nested in a PSTerraformLike Runbook or PSTerraformLike DSC Configuration and nested in the Action property
Output:
    Action:
    - Start-Service:
        DisplayName: None
        WhatIf: "False"
        PassThru: "False"
        Name: None
        Exclude: None
        Confirm: "False"
        InputObject: None
        Include: None
 ``` 
 
### EXAMPLE 2
 ``` 
 Command: ConvertTo-PSTerraformLikeAction -Command 'Start-Service' -Compress
 ``` 
 ```yam 
 Description: This will compress the Start-Service YAML information
Notes:
Output:
    Actions: |-
    - write-host: {"Object":"None","BackgroundColor":"None","ForegroundColor":"None","Separator":"None","NoNewline":"False"}
 ``` 
 
### EXAMPLE 3
 ``` 
 Command: ConvertTo-PSTerraformLikeAction -Help
 ``` 
 ```yam 
 Description: Call Help Information
Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter
 ``` 
 
### EXAMPLE 4
 ``` 
 Command: ConvertTo-PSTerraformLikeAction -WalkThrough
 ``` 
 ```yam 
 Description: Call Help Information [2]
Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter
 ``` 


## PARAMETERS

### Command
 ```yam 
 -Command <String>
    Description: The PowerShell command to convert to a YAML configuration file
    Notes:
    Alias:
    ValidateSet:
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
 ``` 
### Compress
 ```yam 
 -Compress [<SwitchParameter>]
    Description: Compress the Nested Action Object
    Notes:
    Alias:
    ValidateSet:
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Accept wildcard characters?  false
 ``` 
### Walkthrough
 ```yam 
 -Walkthrough [<SwitchParameter>]
    Description:  Start the dynamic help menu system to help walk through the current command and all of the parameters
    Notes:
    Alias: Help
    ValidateSet:
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Accept wildcard characters?  false
 ```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).


