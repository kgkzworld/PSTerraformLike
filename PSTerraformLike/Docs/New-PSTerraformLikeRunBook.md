# New-PSTerraformLikeRunBook

## SYNOPSIS
New-PSTerraformLikeRunBook will create a new PSTerraformLike RunBook template.

Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and declarative manner.
        Terraform is not required to use this module.

## SYNTAX
```
New-PSTerraformLikeRunBook [[-Path] <String>] [-Walkthrough] [<CommonParameters>]
```

## DESCRIPTION
New-PSTerraformLikeRunBook will create a new PSTerraformLike RunBook template.

Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and 
declarative manner.
        Terraform is not required to use this module.

## EXAMPLES

### EXAMPLE 1
 ``` 
 Command: New-PSTerraformLikeRunBook
 ``` 
 ```yam 
 Description: This will create a new PSTerraformLike RunBook template in the current directory with the current date as the filename
Notes:
Output:
 ``` 
 
### EXAMPLE 2
 ``` 
 Command: New-PSTerraformLikeRunBook -Path 'C:\Temp\MyRunBook.yaml'
 ``` 
 ```yam 
 Description: This will create a new PSTerraformLike RunBook template in the C:\Temp directory with the filename of MyRunBook.yaml
Notes:
Output:
 ``` 
 
### EXAMPLE 3
 ``` 
 Command: New-PSTerraformLikeRunBook -Help
 ``` 
 ```yam 
 Description: Call Help Information
Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter
 ``` 
 
### EXAMPLE 4
 ``` 
 Command: New-PSTerraformLikeRunBook -WalkThrough
 ``` 
 ```yam 
 Description: Call Help Information [2]
Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter
 ``` 


## PARAMETERS

### Path
 ```yam 
 -Path <String>
    Description: Full path to the filename to be created
    Notes: If you do not select a path, the file will be created in the current directory and the current date will be 
    used as the filename
            Example: .\RunBook_11.29.2023_6.35.39_PM.YAML
    Alias:
    ValidateSet:
    
    Required?                    false
    Position?                    1
    Default value                $('.\RunBook_{0}.yaml' -f $(Get-Date).ToString() -replace '/|:','.' -replace '\s+','_')
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


