#region ConvertTo-PSTerraformLikeAction (Function)
Function ConvertTo-PSTerraformLikeAction
{
<#
    .SYNOPSIS
        ConvertTo-PSTerraformLikeAction will convert a PowerShell command to a YAML configuration file that can be used with PSTerraformLike

        Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and declarative manner.
                Terraform is not required to use this module.

    .DESCRIPTION
        ConvertTo-PSTerraformLikeAction will convert a PowerShell command to a YAML configuration file that can be used with PSTerraformLike

        Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and declarative manner.
                Terraform is not required to use this module.

    .PARAMETER Command
        Description: The PowerShell command to convert to a YAML configuration file
        Notes:
        Alias:
        ValidateSet:

    .PARAMETER Compress
        Description: Compress the Nested Action Object
        Notes:
        Alias:
        ValidateSet:

    .PARAMETER Walkthrough
        Description:  Start the dynamic help menu system to help walk through the current command and all of the parameters
        Notes:
        Alias: Help
        ValidateSet:

    .EXAMPLE
        Command: ConvertTo-PSTerraformLikeAction -Command 'Start-Service'
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

    .EXAMPLE
        Command: ConvertTo-PSTerraformLikeAction -Command 'Start-Service' -Compress
        Description: This will compress the Start-Service YAML information
        Notes:
        Output:
            Actions: |-
            - write-host: {"Object":"None","BackgroundColor":"None","ForegroundColor":"None","Separator":"None","NoNewline":"False"}

    .EXAMPLE
        Command: ConvertTo-PSTerraformLikeAction -Help
        Description: Call Help Information
        Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter

    .EXAMPLE
        Command: ConvertTo-PSTerraformLikeAction -WalkThrough
        Description: Call Help Information [2]
        Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter


    .OUTPUTS
        TypeName: YAML

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
    [Alias('ConvertTo-TFLA','TFLA')]
    #region Parameters
    Param
    (
        [Parameter(Position = 0)]
        [String]$Command,

        [Switch]$Compress,

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
            #region process Script Block Execution Check
                If ( -Not $fbegin ) {
                    #Clean Exit (Do not process anything further)
                    $fprocess = $false
                    Return
                }
            #endregion process Script Block Execution Check

            #region Main
                #region Query Parameter Set
                    $commandInfo = Get-Help -Name $Command -ErrorAction SilentlyContinue
                #endregion Query Parameter Set

                #region Iterate through the parameters of the command
                    $parameters = @{}

                    foreach ($parameter in $commandInfo.parameters.parameter | Select-Object -Property Name,ParameterValue,DefaultValue) {
                        # Get the default value of the parameter
                        $defaultValue = $parameter.defaultValue

                        # Check if the parameter is a switch or boolean
                        if ($parameter.ParameterValue -eq 'SwitchParameter' -or $parameter.ParameterValue -eq 'Boolean') {
                            # Set the switch value based on the default value
                            $value = if ($defaultValue -eq 'True') { $true } else { $false }
                        }
                        else {
                            # Set the parameter value to the default value
                            $value = $defaultValue
                        }

                        # Add the parameter and its value to the hashtable
                        $parameters[$parameter.Name] = $value
                    }
                #endregion Iterate through the parameters of the command

                #region Create Object Return
                    If ( $Compress ) {
                        $ActionObject = @"
Actions:
- $($Command): $($parameters | ConvertTo-Json -Depth 10 -Compress | ForEach-Object -Process { [regex]::Unescape($_) })
"@
                    } Else {
                        $parentObject = New-Object -TypeName PSObject
                        $parentObject | Add-Member -MemberType NoteProperty -Name $Command -Value $parameters

                        # Create a Action Object and Nest the parent object inside it
                        $ActionObject = New-Object -TypeName PSObject
                        $ActionObjectArray = @()
                        $ActionObjectArray += $parentObject
                        $ActionObject | Add-Member -MemberType NoteProperty -Name Actions -Value $ActionObjectArray
                    }

                    $HashReturn["$HashName"].Info += $ActionObject
                    Remove-Variable -Name ActionObject -Force -ErrorAction Ignore | Out-Null
                #endregion Create Object Return
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

                #region Output Type
                    # Check if the global verbose parameter is used
                    Switch ( $Null ) {
                        { $VerbosePreference -eq 'Continue'} {
                            Return $HashReturn
                            break
                        }

                        { $Compress } {
                            Return $($HashReturn["$HashName"].Info)
                            break
                        }

                        { -Not $Compress } {
                            Return $($HashReturn["$HashName"].Info  | ConvertTo-Yaml)
                        }
                    }
                #endregion Output Type
            #endregion Output
        }
    #endregion end
}
#endregion Get-BluGenieSystemInfo (Function)