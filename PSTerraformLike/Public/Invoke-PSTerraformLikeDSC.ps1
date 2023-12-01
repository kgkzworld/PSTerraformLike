#region Invoke-PSTerraformLikeDSC (Function)
Function Invoke-PSTerraformLikeDSC
{
<#
    .SYNOPSIS
        Invoke-PSTerraformLikeDSC will Initialize a PSTerraformLike (Desired State Config) - DSC

        Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and declarative manner.
                Terraform is not required to use this module.

    .DESCRIPTION
        Invoke-PSTerraformLikeDSC will Initialize a PSTerraformLike (Desired State Config) - DSC

        Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and declarative manner.
                Terraform is not required to use this module.

    .PARAMETER Path
        Description: Specify the path to the YAML file to by Analyzed
        Notes:
        Alias:
        ValidateSet:

    .PARAMETER Remediate
        Description: Remediate any misconfgurations found based on the YAML files set of instructions
        Notes: Be default this is set to $false
        Alias:
        ValidateSet:

    .PARAMETER OnBuild
        Description: RegEx to match the Build Number of the current Operating System
        Notes: Build number is pulled from the Win32_OperatingSystem WMI Class
        Alias:
        ValidateSet:

    .PARAMETER OncpuArch
        Description: RegEx to match the CPU Architecture of the current Operating System
        Notes: CPU Architecture is pulled from $env:PROCESSOR_ARCHITECTURE variable
        Alias:
        ValidateSet:

    .PARAMETER OnOSName
        Description: RegEx to match the OS Name of the current Operating System
        Notes: The Operating System Name is pulled from the Win32_OperatingSystem WMI Class
        Alias:
        ValidateSet:

    .PARAMETER OnProductType
        Description: RegEx to match the Product Type of the current Operating System
        Notes: The Product Type is pulled from the Win32_OperatingSystem WMI Class
                1 = Workstation
                2 = Domain Controller
                3 = Server
                .* = All
        Alias:
        ValidateSet:

    .PARAMETER LoopTimer
        Description: The amount of time to wait before looping through the RemedationTest and the Actions again
        Notes: By default this is set to 0 Seconds
        Alias:
        ValidateSet:

    .PARAMETER LoopCount
        Description: The amount of times to loop through the RemedationTest and the Actions
        Notes: By default this is set to 0 times
        Alias:
        ValidateSet:

    .PARAMETER Walkthrough
        Description:  Start the dynamic help menu system to help walk through the current command and all of the parameters
        Notes:
        Alias: Help
        ValidateSet:

    .EXAMPLE
        Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml
        Description: Run a PSTerraformLike DSC against the computer to determine if the Windows Remote Management Service is enabled
        Notes: This will not remediate any issues found

            Sample DSC Config
            ---
            Config:
                Description: "Enable Windows Remote Management"
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

    .EXAMPLE
        Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml
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

    .EXAMPLE
        Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -Remediate
        Description: Run a PSTerraformLike DSC against the computer and remediate any issues found.
        Notes:
        Output:
            [+] D20231130_T07.46.57.8547.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
            [+] D20231130_T07.46.58.3051.PM_Z-5 - Successful: Start-Service {"Name":"WinRM"}
            [+] D20231130_T07.46.58.4694.PM_Z-5 - Successful: Windows.Remote.Management_Enable_1.0.0.20231129
            [+] D20231130_T07.46.58.4694.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129

    .EXAMPLE
        Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -Remediate -LoopTimer 20
        Description: Use the LoopTimer to wait 20 seconds before running the Pester Test after the Initial Actions have been run
        Notes:
        Output:
            [+] D20231130_T07.49.08.7829.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
            [+] D20231130_T07.49.09.2036.PM_Z-5 - Successful: Start-Service {"Name":"WinRM"}
            [+] D20231130_T07.49.29.4189.PM_Z-5 - Successful: Windows.Remote.Management_Enable_1.0.0.20231129
            [+] D20231130_T07.49.29.4189.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129

    .EXAMPLE
        Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -OnProductType 3
        Description: Only run the DSC if the current Operating System is a Server
        Notes:  This will bypass the DSC Configurations OnProductType value and only run with this executions OnProductType value
        Output:
            [+] D20231130_T07.55.37.0873.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
            [!] D20231130_T07.55.37.2494.PM_Z-5 - Bypassing: Product Type 1 does not match 3
            [+] D20231130_T07.55.37.2504.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129

    .EXAMPLE
        Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -OnBuild 22000
        Description: Only run the DSC if the current Operating System Build Number is 22000
        Notes: This will bypass the DSC Configurations OnBuild value and only run with this executions OnBuild value
        Output:
            [+] D20231130_T07.57.31.2981.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
            [!] D20231130_T07.57.31.4677.PM_Z-5 - Bypassing: Build Number 22621 does not match 22000
            [+] D20231130_T07.57.31.4677.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129

    .EXAMPLE
        Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -OnCpuArch 'ARM'
        Description: Only run the DSC if the current Operating System CPU Architecture is ARM
        Notes: This will bypass the DSC Configurations OncpuArch value and only run with this executions OncpuArch value
        Output:
            [+] D20231130_T08.00.19.9808.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
            [!] D20231130_T08.00.20.1540.PM_Z-5 - Bypassing: CPU Architecture AMD64 does not match ARM
            [+] D20231130_T08.00.20.1540.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129

    .EXAMPLE
        Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -OnOSName 'Server'
        Description: Only run the DSC if the current Operating System Name contains the word Server
        Notes: This will bypass the DSC Configurations OnOSName value and only run with this executions OnOSName value
        Output:
            [+] D20231130_T08.01.14.1963.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
            [!] D20231130_T08.01.14.3685.PM_Z-5 - Bypassing: OS Name Microsoft Windows 11 Pro does not match Server
            [+] D20231130_T08.01.14.3685.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129

    .EXAMPLE
        Command: Invoke-PSTerraformLikeDSC -path .\Windows.Remote.Management_Enable_1.0.0.20231129.yaml -Remediate -LoopTimer 20 -LoopCount 2
        Description: Loop through the Remedation Test and if the test still fails run the Actions again based on the LoopCount (In this case 2 times)
        Notes: Make sure you LoopTimer in the DSC config or the LoopTimer parameter is set to a value greater than 0
        Output:
            [+] D20231130_T07.49.08.7829.PM_Z-5 - Starting: Windows.Remote.Management_Enable_1.0.0.20231129
            [+] D20231130_T07.49.09.2036.PM_Z-5 - Successful: Start-Service {"Name":"WinRM"}
            [+] D20231130_T07.49.29.4189.PM_Z-5 - Successful: Windows.Remote.Management_Enable_1.0.0.20231129
            [+] D20231130_T07.49.29.4189.PM_Z-5 - Finished: Windows.Remote.Management_Enable_1.0.0.20231129

    .EXAMPLE
        Command: Invoke-PSTerraformLikeDSC -Help
        Description: Call Help Information
        Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter

    .EXAMPLE
        Command: Invoke-PSTerraformLikeDSC -WalkThrough
        Description: Call Help Information [2]
        Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter


    .OUTPUTS
        TypeName: PSObject

    .NOTES
        • [Original Author]
            o Michael Arroyo
        • [Original Build Version]
            o 1.0.0.20231129 [XX = Major (.) XX = Minor (.) XX = Patch (.) XX = Build Date (YYYYMMDD)]
        • [Latest Author]
            o Michael Arroyo
        • [Latest Build Version]
            o 1.0.0.20231129 [XX = Major (.) XX = Minor (.) XX = Patch (.) XX = Build Date (YYYYMMDD)]
        • [Comments]
            o
        • [PowerShell Compatibility]
            o  5.x, 7.x
        • [Forked Project]
            o
        • [Links]
            o
        • [Dependencies]
            o Module - Powershell-yaml
            o Command - Invoke-WalkThrough
#>

#region Build Notes
<#
~ Build Version Details "Moved from main help.  There is a Char limit and PSHelp could not read all the information correctly":
        o 1.0.0.20231129
            [Michael Arroyo] Initial Post
#>
#endregion Build Notes
    [cmdletbinding()]
    [Alias('Invoke-TFLDSC','TFLIDSC')]
    #region Parameters
    Param
    (
        [Parameter(Position = 0)]
        [String]$Path,

        [Alias('Update')]
        [Switch]$Remediate,

        [String]$OnBuild,

        [String]$OnCpuArch,

        [String]$OnOSName,

        [String]$OnProductType,

        [Int]$LoopTimer = 0,

        [Int]$LoopCount = 0,

        [Alias('Help')]
        [Switch]$Walkthrough
    )
    #endregion Parameters

    #region begin
        begin
        {
            Write-Verbose 'Begin block'

            #region Load begin, and process (code execution flags)
                $fbegin = $true
                $fprocess = $true
            #endregion Load begin, and process (code execution flags)

            #region WalkThrough (Dynamic Help)
                If( $Walkthrough ) {
                    If ( $($PSCmdlet.MyInvocation.InvocationName) ) {
                        $Function = $($PSCmdlet.MyInvocation.InvocationName)
                    } Else {
                        If ( $Host.Name -match 'ISE' ) {
                            $Function = $(Split-Path -Path $psISE.CurrentFile.FullPath -Leaf) -replace '((?:.[^.\r\n]*){1})$'
                        }
                    }

                    If ( Test-Path -Path Function:\Invoke-WalkThrough -ErrorAction SilentlyContinue ) {
                        If ( $Function -eq 'Invoke-WalkThrough' ) {
                            #Disable Invoke-WalkThrough looping
                            Invoke-Command -ScriptBlock { Invoke-WalkThrough -Name $Function -RemoveRun }
                            $fbegin = $false
                            Return
                        } Else {
                            Invoke-Command -ScriptBlock { Invoke-WalkThrough -Name $Function }
                            $fbegin = $false
                            Return
                        }
                    } Else {
                        Get-Help -Name $Function -Full
                        $fbegin = $false
                        Return
                    }
                }
            #endregion WalkThrough (Dynamic Help)

            #region Common Variables
                If ( $($MyInvocation.InvocationName) ) {
                    $ScriptName = $($MyInvocation.InvocationName)
                } Else {
                    $ScriptName = $(Split-Path -Path $psISE.CurrentFile.FullPath -Leaf) -replace '((?:.[^.\r\n]*){1})$'
                }
            #endregion Common Variables

            #region Create Return hash
                $HashName = $ScriptName -replace '[^x20-x7e]+'
                $HashReturn = @{}
                $HashReturn["$HashName"] = @{}
                $StartTime = $(Get-Date -ErrorAction SilentlyContinue)
                $HashReturn["$HashName"].StartTime = $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz)
                $HashReturn["$HashName"].Comments = @()
                $HashReturn["$HashName"].ParameterSetResults = @()
                $HashReturn["$HashName"].Info = @()
            #endregion Create Return hash

            #region Parameter Set Results
                $HashReturn["$HashName"].ParameterSetResults += $PSBoundParameters
            #endregion Parameter Set Results
        }
    #endregion begin

    #region process
        Process
        {
            Write-Verbose 'Process block'
            #region process Script Block Execution Check
                If ( -Not $fbegin ) {
                    #Clean Exit (Do not process anything further)
                    $fprocess = $false
                    Return
                }
            #endregion process Script Block Execution Check

            #region Main
                Try {
                    $Info = Get-Content -Path $Path -Raw -ErrorAction Stop | ConvertFrom-Yaml -ErrorAction Stop
                    $HashReturn["$HashName"].Info += $('[+] {0} - Starting: {1}_{2}_{3}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $info.Config.Title, $info.Config.Method, $info.Config.Version)

                    Switch ( $Null ) {
                        { $OnBuild } {
                            $info.config.run.OnBuild = $OnBuild
                        }

                        { $OnCpuArch } {
                            $info.config.run.OnCpuArch = $OnCpuArch
                        }

                        { $OnOSName } {
                            $info.config.run.OnOSName = $OnOSName
                        }

                        { $OnProductType } {
                            $info.config.run.OnProductType = $OnProductType
                        }

                        { $LoopTimer -gt $info.Testing.LoopTimer } {
                            $info.Testing.LoopTimer = $LoopTimer
                        }

                        { $LoopCount -gt $info.Testing.LoopCount } {
                            $info.Testing.LoopCount = $LoopCount
                        }

                        { $LoopCount -eq 0 -and $info.Testing.LoopCount -eq 0 } {
                            $info.Testing.LoopCount = 1
                        }
                    }
                } Catch {
                    $HashReturn["$HashName"].Comments += $('[!] {0} - Error: {1}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $($Error[0].Exception.Message))
                    $HashReturn["$HashName"].Info += $('[!] {0} - Error: {1}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $($Error[0].Exception.Message))
                    $fprocess = $false
                    Return
                }

                $CurWMIClass = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction SilentlyContinue | Select-Object -Property *
                $CurOnBuild = $CurWMIClass.BuildNumber
                $CurOncpuArch = $env:PROCESSOR_ARCHITECTURE
                $CurOnOSName = $CurWMIClass.Caption
                $CurOnProductType = $CurWMIClass.ProductType

                If ( $Info.config.run.OnBuild.Length -gt 0) {
                    If ( -Not $($CurOnBuild -match $Info.config.run.OnBuild) ) {
                        $HashReturn["$HashName"].Comments += $('[!] {0} - Bypassing: Build Number {1} does not match {2}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $CurOnBuild, $Info.config.run.OnBuild)
                        $HashReturn["$HashName"].Info += $('[!] {0} - Bypassing: Build Number {1} does not match {2}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $CurOnBuild, $Info.config.run.OnBuild)
                        Return
                    }
                }

                If ( $Info.config.run.OnCpuArch.Length -gt 0) {
                    If ( -Not $($CurOncpuArch -match $Info.config.run.OnCpuArch) ) {
                        $HashReturn["$HashName"].Comments += $('[!] {0} - Bypassing: CPU Architecture {1} does not match {2}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $CurOncpuArch, $Info.config.run.OnCpuArch)
                        $HashReturn["$HashName"].Info += $('[!] {0} - Bypassing: CPU Architecture {1} does not match {2}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $CurOncpuArch, $Info.config.run.OnCpuArch)
                        Return
                    }
                }

                If ( $Info.config.run.OnOSName.Length -gt 0) {
                    If ( -Not $($CurOnOSName -match $Info.config.run.OnOSName) ) {
                        $HashReturn["$HashName"].Comments += $('[!] {0} - Bypassing: OS Name {1} does not match {2}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $CurOnOSName, $Info.config.run.OnOSName)
                        $HashReturn["$HashName"].Info += $('[!] {0} - Bypassing: OS Name {1} does not match {2}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $CurOnOSName, $Info.config.run.OnOSName)
                        Return
                    }
                }

                If ( $Info.config.run.OnProductType.Length -gt 0) {
                    If ( -Not $($CurOnProductType -match $Info.config.run.OnProductType) ) {
                        $HashReturn["$HashName"].Comments += $('[!] {0} - Bypassing: Product Type {1} does not match {2}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $CurOnProductType, $Info.config.run.OnProductType)
                        $HashReturn["$HashName"].Info += $('[!] {0} - Bypassing: Product Type {1} does not match {2}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $CurOnProductType, $Info.config.run.OnProductType)
                        Return
                    }
                }

                $Error.Clear()

                Switch ( $Null ) {
                    { $Info.Testing.RemediationTest } {
                        $Info.Testing.RemediationTest = [scriptblock]::Create( $Info.Testing.RemediationTest )
                    }

                    { $Info.Testing.PesterTest } {
                        $Info.Testing.PesterTest = [scriptblock]::Create( $Info.Testing.PesterTest )
                    }
                }

                If ( $Remediate ) {
                    For ($i = 0; $i -lt $Info.Testing.LoopCount; $i++) {
                        If ( -Not $(Invoke-Command -ScriptBlock $info.Testing.RemediationTest) ) {
                            foreach ($property in $info.Actions) {
                                $command = $property.keys
                                $parameters = $property[$($command)]
                                $parameterUpdate = $parameters.Clone()

                                # Convert True/False to PowerShell boolean values
                                foreach ($key in $parameters.Keys) {
                                    if ($parameters[$key] -eq $true) {
                                        $parameterUpdate[$key] = $true
                                    } elseif ($parameters[$key] -eq $false) {
                                        $parameterUpdate[$key] = $false
                                    }
                                }

                                # Run the PowerShell command using splatting
                                $Error.Clear()
                                Invoke-Expression -Command "$command @parameterUpdate"

                                If ( $Error.Count -gt 0 ) {
                                    $HashReturn["$HashName"].Comments += $('[!] {0} - Error: {1}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $($Error[0].Exception.Message))
                                    $HashReturn["$HashName"].Info += $('[!] {0} - Failed: {1} {2}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $($command), $($parameters | ConvertTo-Json -Depth 10 -Compress | ForEach-Object -Process { [regex]::Unescape($_)}))
                                } Else {
                                    $HashReturn["$HashName"].Info += $('[+] {0} - Successful: {1} {2}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $($command), $($parameters | ConvertTo-Json -Depth 10 -Compress | ForEach-Object -Process { [regex]::Unescape($_)}))
                                }
                            }

                            Start-Sleep -Seconds $Info.Testing.LoopTimer
                        } Else {
                            $i = $Info.Testing.LoopCount
                        }
                    }
                }

                $Global:Error.Clear()
                Invoke-Command -ScriptBlock $Info.Testing.PesterTest

                If ( $Global:Error.Count -gt 0 ) {
                    $HashReturn["$HashName"].Comments += $('[!] {0} - Error: {1}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $($Global:Error[0].Exception.Message))
                    $HashReturn["$HashName"].Info += $('[!] {0} - Failed: {1}_{2}_{3}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $info.Config.Title, $info.Config.Method, $info.Config.Version)
                    $HashReturn["$HashName"].Info += $('[!] {0} - Error: {1}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $($Global:Error[0].Exception.Message))
                } Else {
                    $HashReturn["$HashName"].Info += $('[+] {0} - Successful: {1}_{2}_{3}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $info.Config.Title, $info.Config.Method, $info.Config.Version)
                }
            #endregion Main
        }
    #endregion process

    #region end
        end
        {
            Write-Verbose 'Final work in End block'

            #region Script Block Execution Check
                If ( -Not $fprocess ) {
                    #Clean Exit (Do not process anything further)
                    Return
                }
            #endregion Script Block Execution Check

            #region Output
                $EndTime = $(Get-Date -ErrorAction SilentlyContinue)
                $HashReturn["$HashName"].EndTime = $($EndTime).DateTime
                $HashReturn["$HashName"].ElapsedTime = $(New-TimeSpan -Start $StartTime -End $EndTime -ErrorAction SilentlyContinue) | `
                    Select-Object -Property Days, Hours, Milliseconds, Minutes, Seconds
                    $HashReturn["$HashName"].Info += $('[+] {0} - Finished: {1}_{2}_{3}' -f $(Get-Date -Format DyyyyMMdd_Thh.mm.ss.ffff.tt_Zz), $info.Config.Title, $info.Config.Method, $info.Config.Version)

                #region Output Type
                    # Check if the global verbose parameter is used
                    Switch ( $Null ) {
                        { $VerbosePreference -eq 'Continue'} {
                            Return $HashReturn
                            break
                        }

                        { -Not $($VerbosePreference -eq 'Continue') } {
                            Return $($HashReturn["$HashName"].Info)
                        }
                    }
                #endregion Output Type
            #endregion Output
        }
    #endregion end
}
#endregion Get-BluGenieSystemInfo (Function)