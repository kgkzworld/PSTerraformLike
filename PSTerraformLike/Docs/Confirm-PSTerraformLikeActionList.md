# Confirm-PSTerraformLikeActionList

## SYNOPSIS
Confirm-PSTerraformLikeActionList will validate all Action items to make sure each command has the correct parameter properties

Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and declarative manner.
        Terraform is not required to use this module.

## SYNTAX
```
Confirm-PSTerraformLikeActionList [[-Path] <String>] [-Walkthrough] [<CommonParameters>]
```

## DESCRIPTION
Confirm-PSTerraformLikeActionList will validate all Action items to make sure each command has the correct parameter 
properties

Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and 
declarative manner.
        Terraform is not required to use this module.

## EXAMPLES

### EXAMPLE 1
 ``` 
 Command: Confirm-PSTerraformLikeActionList .\CleanFile.yaml
 ``` 
 ```yam 
 Description: This will parse properties of each item in the Action list to make sure they are valid
Notes: There are 2 Actions in this example.  The first Action has valid parameters and the second Action shows the parameters are not valid.
Output:
    Describing Parameter Validation for [REMOVE-ITEM]
    [+] Parameter [CONFIRM] should exist 3ms
    [+] Parameter [PATH] should exist 3ms
    [+] Parameter [FORCE] should exist 3ms

    Describing Parameter Validation for [REMOVE-ITEM]
    [+] Parameter [CONFIRM] should exist 2ms
    [+] Parameter [PATH] should exist 2ms
    [-] Parameter [UPDATE] should exist 4ms
        Expected 'Update' to be found in collection
        @('Credential', 'Exclude', 'Filter', 'Force', 'Include', 'LiteralPath', 'Path', 'Recurse', 'Stream', 'UseTransaction'), but it was not found.
        198: $lookupParams | Should -Contain $key
        at <ScriptBlock>, Confirm-PSTerraformLikeActionList.ps1: line 198

    ValidConfig
    -----------
        False
 ``` 
 
### EXAMPLE 2
 ``` 
 Command: Confirm-PSTerraformLikeActionList -Help
 ``` 
 ```yam 
 Description: Call Help Information
Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter
 ``` 
 
### EXAMPLE 3
 ``` 
 Command: Confirm-PSTerraformLikeActionList -WalkThrough
 ``` 
 ```yam 
 Description: Call Help Information [2]
Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter
 ``` 


## PARAMETERS

### Path
 ```yam 
 -Path <String>
    Description: Specify the path to the YAML file to by Analyzed
    Notes:
    Alias:
    ValidateSet:
    
    Required?                    false
    Position?                    1
    Default value                
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


