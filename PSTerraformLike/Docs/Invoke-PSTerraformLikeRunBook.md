# Invoke-PSTerraformLikeRunBook

## SYNOPSIS
Invoke-PSTerraformLikeRunBook will Initialize a PSTerraformLike (Desired State Config) - DSC

Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and declarative manner.
        Terraform is not required to use this module.

## SYNTAX
```
Invoke-PSTerraformLikeRunBook [[-Path] <String>] [-Remediate] [-OnBuild <String>] [-OnCpuArch <String>] [-OnOSName 
<String>] [-OnProductType <String>] [-Walkthrough] [<CommonParameters>]
```

## DESCRIPTION
Invoke-PSTerraformLikeRunBook will Initialize a PSTerraformLike (Desired State Config) - DSC

Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and 
declarative manner.
        Terraform is not required to use this module.

## EXAMPLES

### EXAMPLE 1
 ``` 
 Command:  Invoke-PSTerraformLikeRunBook -Path .\RunBook_11.29.2023_9.49.32_PM.yaml
 ``` 
 ```yam 
 Description: Run a PSTerraformLike Runbook against the computer
Notes:

    Sample RunBook Config
    ---
    Config:Description: This is a sample RunBook for PSTerraformLike
        Version: 1.0.0.20231129
        Run:
            OnProductType: .*
            OnBuild: .*
            OncpuArch: AMD64
            OnOSName: .*Windows.*
        Author: Michael Arroyo
        Title: Sample.RunBook
        Actions:
        - Invoke-PSTerraformLikeDSC:
            Path: '.\RunBook_11.29.2023_9.49.32_PM.yaml'
        - Write-Host:
            ForegroundColor: Green
            Object: 'This is a test message'
Output:
    Successful Example:
    [+] D20231201_T11.48.38.2897.AM_Z-5 - Starting: Sample.RunBook_1.0.0.20231129
    [+] D20231201_T11.48.38.6259.AM_Z-5 - Successful: Windows.Remote.Management_Enable_1.0.0.20231129
    [+] D20231201_T11.48.38.6272.AM_Z-5 - Successful: Sample.RunBook_1.0.0.20231129
    [+] D20231201_T11.48.38.6272.AM_Z-5 - Finished: Sample.RunBook_1.0.0.20231129

    Failed Example:
    [+] D20231201_T11.51.56.8272.AM_Z-5 - Starting: Sample.RunBook_1.0.0.20231129
    [!] D20231201_T11.51.57.1531.AM_Z-5 - Failed: Windows.Remote.Management_Enable_1.0.0.20231129
    [!] D20231201_T11.51.57.1531.AM_Z-5 - Error: Expected 'Running', but got Stopped.
    [!] D20231201_T11.51.57.1540.AM_Z-5 - Error: Sample.RunBook_1.0.0.20231129
    [+] D20231201_T11.51.57.1550.AM_Z-5 - Finished: Sample.RunBook_1.0.0.20231129
 ``` 
 
### EXAMPLE 2
 ``` 
 Command: Invoke-PSTerraformLikeRunBook -path .\RunBook_11.29.2023_9.49.32_PM.yaml -Remediate
 ``` 
 ```yam 
 Description: Run a PSTerraformLike Runbook against the computer and remediate any issues found.
Notes: This will override the DSC Configurations Remediate value.
        This allows you to build check only runbooks and then remediate them later if needed without having to change the RunBook Config.
Output:
    [+] D20231201_T11.48.38.2897.AM_Z-5 - Starting: Sample.RunBook_1.0.0.20231129
    [+] D20231201_T11.48.38.6259.AM_Z-5 - Successful: Windows.Remote.Management_Enable_1.0.0.20231129
    [+] D20231201_T11.48.38.6272.AM_Z-5 - Successful: Sample.RunBook_1.0.0.20231129
    [+] D20231201_T11.48.38.6272.AM_Z-5 - Finished: Sample.RunBook_1.0.0.20231129
 ``` 
 
### EXAMPLE 3
 ``` 
 Command: Invoke-PSTerraformLikeRunBook -path .\RunBook_11.29.2023_9.49.32_PM.yaml -OnProductType 3
 ``` 
 ```yam 
 Description: Only run the Runbook if the current Operating System is a Server
Notes:  This will bypass the Runbook Configurations OnProductType value and only run with this executions OnProductType value
Output:
    [+] D20231130_T07.55.37.0873.PM_Z-5 - Starting: Sample.RunBook_1.0.0.20231129
    [!] D20231130_T07.55.37.2494.PM_Z-5 - Bypassing: Product Type 1 does not match 3
    [+] D20231130_T07.55.37.2504.PM_Z-5 - Finished: Sample.RunBook_1.0.0.20231129
 ``` 
 
### EXAMPLE 4
 ``` 
 Command: Invoke-PSTerraformLikeRunBook -path .\RunBook_11.29.2023_9.49.32_PM.yaml -OnBuild 22000
 ``` 
 ```yam 
 Description: Only run the Runbook if the current Operating System Build Number is 22000
Notes: This will bypass the Runbook Configurations OnBuild value and only run with this executions OnBuild value
Output:
    [+] D20231130_T07.57.31.2981.PM_Z-5 - Starting: Sample.RunBook_1.0.0.20231129
    [!] D20231130_T07.57.31.4677.PM_Z-5 - Bypassing: Build Number 22621 does not match 22000
    [+] D20231130_T07.57.31.4677.PM_Z-5 - Finished: Sample.RunBook_1.0.0.20231129
 ``` 
 
### EXAMPLE 5
 ``` 
 Command: Invoke-PSTerraformLikeRunBook -path .\RunBook_11.29.2023_9.49.32_PM.yaml -OnCpuArch 'ARM'
 ``` 
 ```yam 
 Description: Only run the Runbook if the current Operating System CPU Architecture is ARM
Notes: This will bypass the Runbook Configurations OncpuArch value and only run with this executions OncpuArch value
Output:
    [+] D20231130_T08.00.19.9808.PM_Z-5 - Starting: Sample.RunBook_1.0.0.20231129
    [!] D20231130_T08.00.20.1540.PM_Z-5 - Bypassing: CPU Architecture AMD64 does not match ARM
    [+] D20231130_T08.00.20.1540.PM_Z-5 - Finished: Sample.RunBook_1.0.0.20231129
 ``` 
 
### EXAMPLE 6
 ``` 
 Command: Invoke-PSTerraformLikeRunBook -path .\RunBook_11.29.2023_9.49.32_PM.yaml -OnOSName 'Server'
 ``` 
 ```yam 
 Description: Only run the Runbook if the current Operating System Name contains the word Server
Notes: This will bypass the Runbook Configurations OnOSName value and only run with this executions OnOSName value
Output:
    [+] D20231130_T08.01.14.1963.PM_Z-5 - Starting: Sample.RunBook_1.0.0.20231129
    [!] D20231130_T08.01.14.3685.PM_Z-5 - Bypassing: OS Name Microsoft Windows 11 Pro does not match Server
    [+] D20231130_T08.01.14.3685.PM_Z-5 - Finished: Sample.RunBook_1.0.0.20231129
 ``` 
 
### EXAMPLE 7
 ``` 
 Command: Invoke-PSTerraformLikeRunBook -Help
 ``` 
 ```yam 
 Description: Call Help Information
Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter
 ``` 
 
### EXAMPLE 8
 ``` 
 Command: Invoke-PSTerraformLikeRunBook -WalkThrough
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
### Remediate
 ```yam 
 -Remediate [<SwitchParameter>]
    Description: Remediate any misconfgurations found based on the YAML files set of instructions
    Notes: Be default this is set to $false
    Alias:
    ValidateSet:
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Accept wildcard characters?  false
 ``` 
### OnBuild
 ```yam 
 -OnBuild <String>
    Description: RegEx to match the Build Number of the current Operating System
    Notes: Build number is pulled from the Win32_OperatingSystem WMI Class
            This string will override the RunBook and all nested DSC Configurations OnBuild values
    Alias:
    ValidateSet:
    
    Required?                    false
    Position?                    named
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
 ``` 
### OnCpuArch
 ```yam 
 -OnCpuArch <String>
    Description: RegEx to match the CPU Architecture of the current Operating System
    Notes: CPU Architecture is pulled from $env:PROCESSOR_ARCHITECTURE variable
            This string will override the RunBook and all nested DSC Configurations OncpuArch values
    Alias:
    ValidateSet:
    
    Required?                    false
    Position?                    named
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
 ``` 
### OnOSName
 ```yam 
 -OnOSName <String>
    Description: RegEx to match the OS Name of the current Operating System
    Notes: The Operating System Name is pulled from the Win32_OperatingSystem WMI Class
            This string will override the RunBook and all nested DSC Configurations OnOSName values
    Alias:
    ValidateSet:
    
    Required?                    false
    Position?                    named
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
 ``` 
### OnProductType
 ```yam 
 -OnProductType <String>
    Description: RegEx to match the Product Type of the current Operating System
    Notes: The Product Type is pulled from the Win32_OperatingSystem WMI Class
            1 = Workstation
            2 = Domain Controller
            3 = Server
            .* = All
            This string will override the RunBook and all nested DSC Configurations OnProductType values
    Alias:
    ValidateSet:
    
    Required?                    false
    Position?                    named
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


