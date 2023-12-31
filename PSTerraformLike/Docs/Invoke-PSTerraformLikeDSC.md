# Invoke-PSTerraformLikeDSC

## SYNOPSIS
Invoke-PSTerraformLikeDSC will Initialize a PSTerraformLike (Desired State Config) - DSC

Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and declarative manner.
        Terraform is not required to use this module.

## SYNTAX
```
Invoke-PSTerraformLikeDSC [[-Path] <String>] [-Remediate] [-OnBuild <String>] [-OnCpuArch <String>] [-OnOSName 
<String>] [-OnProductType <String>] [-LoopTimer <Int32>] [-LoopCount <Int32>] [-Walkthrough] [<CommonParameters>]
```

## DESCRIPTION
Invoke-PSTerraformLikeDSC will Initialize a PSTerraformLike (Desired State Config) - DSC

Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and 
declarative manner.
        Terraform is not required to use this module.

## EXAMPLES

### EXAMPLE 1
 ``` 
 Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml
 ``` 
 ```yam 
 Description: Run a PSTerraformLike DSC against the computer to determine if the Windows Remote Management Service is enabled
Notes: This will not remediate any issues found

    Sample DSC Config
    ---
    Config:Description: "Enable Windows Remote Management"
        Method: "Enable"
        Version: "1.0.0.20231129"
        Run:
            OnProductType: "1"
            OnBuild: .*
            OncpuArch: AMD64
            OnOSName: .*Windows.*
        Author: "Michael Arroyo"
        Title: "Windows.Remote.Management"
        Testing:
        LoopTimer: 0
        RemediationTest: |-
            If ($(Get-Service -name winrm).Status -eq 'Running') {
                $true
            } else {
                $false
            }
        LoopCount: 0
        PesterTest: |-
            Describe "WinRM Service Status" {
                $CurWinRmStatus = $(Get-Service -name winrm).Status
                It "WinRM is [Running]" {
                    $CurWinRmStatus | should -be 'Running'
                }
            }
        Actions:
        - Start-Service:
            Name: WinRM
Output:
 ``` 
 
### EXAMPLE 2
 ``` 
 Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml
 ``` 
 ```yam 
 Description: Run a PSTerraformLike DSC against the computer.  Do not remediate any issues found.
Notes:
Output:
    Successful Example:
    [+] D20231130_T07.50.26.9906.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
    [+] D20231130_T07.50.27.3406.PM_Z-5 - Successful: Windows.Remote.Management_Enable_1.0.0.20231129
    [+] D20231130_T07.50.27.3416.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129

    Failed Example:
    [+] D20231130_T07.52.08.7593.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
    [!] D20231130_T07.52.09.0880.PM_Z-5 - Failed: Windows.Remote.Management_Enable_1.0.0.20231129
    [!] D20231130_T07.52.09.0880.PM_Z-5 - Error: Expected 'Running', but got Stopped.
    [+] D20231130_T07.52.09.0890.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129
 ``` 
 
### EXAMPLE 3
 ``` 
 Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -Remediate
 ``` 
 ```yam 
 Description: Run a PSTerraformLike DSC against the computer and remediate any issues found.
Notes:
Output:
    [+] D20231130_T07.46.57.8547.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
    [+] D20231130_T07.46.58.3051.PM_Z-5 - Successful: Start-Service {"Name":"WinRM"}
    [+] D20231130_T07.46.58.4694.PM_Z-5 - Successful: Windows.Remote.Management_Enable_1.0.0.20231129
    [+] D20231130_T07.46.58.4694.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129
 ``` 
 
### EXAMPLE 4
 ``` 
 Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -Remediate -LoopTimer 20
 ``` 
 ```yam 
 Description: Use the LoopTimer to wait 20 seconds before running the Pester Test after the Initial Actions have been run
Notes:
Output:
    [+] D20231130_T07.49.08.7829.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
    [+] D20231130_T07.49.09.2036.PM_Z-5 - Successful: Start-Service {"Name":"WinRM"}
    [+] D20231130_T07.49.29.4189.PM_Z-5 - Successful: Windows.Remote.Management_Enable_1.0.0.20231129
    [+] D20231130_T07.49.29.4189.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129
 ``` 
 
### EXAMPLE 5
 ``` 
 Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -OnProductType 3
 ``` 
 ```yam 
 Description: Only run the DSC if the current Operating System is a Server
Notes:  This will bypass the DSC Configurations OnProductType value and only run with this executions OnProductType value
Output:
    [+] D20231130_T07.55.37.0873.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
    [!] D20231130_T07.55.37.2494.PM_Z-5 - Bypassing: Product Type 1 does not match 3
    [+] D20231130_T07.55.37.2504.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129
 ``` 
 
### EXAMPLE 6
 ``` 
 Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -OnBuild 22000
 ``` 
 ```yam 
 Description: Only run the DSC if the current Operating System Build Number is 22000
Notes: This will bypass the DSC Configurations OnBuild value and only run with this executions OnBuild value
Output:
    [+] D20231130_T07.57.31.2981.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
    [!] D20231130_T07.57.31.4677.PM_Z-5 - Bypassing: Build Number 22621 does not match 22000
    [+] D20231130_T07.57.31.4677.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129
 ``` 
 
### EXAMPLE 7
 ``` 
 Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -OnCpuArch 'ARM'
 ``` 
 ```yam 
 Description: Only run the DSC if the current Operating System CPU Architecture is ARM
Notes: This will bypass the DSC Configurations OncpuArch value and only run with this executions OncpuArch value
Output:
    [+] D20231130_T08.00.19.9808.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
    [!] D20231130_T08.00.20.1540.PM_Z-5 - Bypassing: CPU Architecture AMD64 does not match ARM
    [+] D20231130_T08.00.20.1540.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129
 ``` 
 
### EXAMPLE 8
 ``` 
 Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -OnOSName 'Server'
 ``` 
 ```yam 
 Description: Only run the DSC if the current Operating System Name contains the word Server
Notes: This will bypass the DSC Configurations OnOSName value and only run with this executions OnOSName value
Output:
    [+] D20231130_T08.01.14.1963.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
    [!] D20231130_T08.01.14.3685.PM_Z-5 - Bypassing: OS Name Microsoft Windows 11 Pro does not match Server
    [+] D20231130_T08.01.14.3685.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129
 ``` 
 
### EXAMPLE 9
 ``` 
 Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -Remediate -LoopTimer 20 -LoopCount 2
 ``` 
 ```yam 
 Description: Loop through the Remedation Test and if the test still fails run the Actions again based on the LoopCount (In this case 2 times)
Notes: Make sure you LoopTimer in the DSC config or the LoopTimer parameter is set to a value greater than 0
Output:
    [+] D20231130_T07.49.08.7829.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
    [+] D20231130_T07.49.09.2036.PM_Z-5 - Successful: Start-Service {"Name":"WinRM"}
    [+] D20231130_T07.49.29.4189.PM_Z-5 - Successful: Windows.Remote.Management_Enable_1.0.0.20231129
    [+] D20231130_T07.49.29.4189.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129
 ``` 
 
### EXAMPLE 10
 ``` 
 Command: Invoke-PSTerraformLikeDSC -Help
 ``` 
 ```yam 
 Description: Call Help Information
Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter
 ``` 
 
### EXAMPLE 11
 ``` 
 Command: Invoke-PSTerraformLikeDSC -WalkThrough
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
    Alias:
    ValidateSet:
    
    Required?                    false
    Position?                    named
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
 ``` 
### LoopTimer
 ```yam 
 -LoopTimer <Int32>
    Description: The amount of time to wait before looping through the RemedationTest and the Actions again
    Notes: By default this is set to 0 Seconds
    Alias:
    ValidateSet:
    
    Required?                    false
    Position?                    named
    Default value                0
    Accept pipeline input?       false
    Accept wildcard characters?  false
 ``` 
### LoopCount
 ```yam 
 -LoopCount <Int32>
    Description: The amount of times to loop through the RemedationTest and the Actions
    Notes: By default this is set to 0 times
    Alias:
    ValidateSet:
    
    Required?                    false
    Position?                    named
    Default value                0
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


