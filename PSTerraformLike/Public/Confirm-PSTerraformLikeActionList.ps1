#region Confirm-PSTerraformLikeActionList (Function)
Function Confirm-PSTerraformLikeActionList
{
<#
    .SYNOPSIS
        Confirm-PSTerraformLikeActionList will validate all Action items to make sure each command has the correct parameter properties

        Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and declarative manner.
                Terraform is not required to use this module.

    .DESCRIPTION
        Confirm-PSTerraformLikeActionList will validate all Action items to make sure each command has the correct parameter properties

        Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and declarative manner.
                Terraform is not required to use this module.

    .PARAMETER Path
        Description: Specify the path to the YAML file to by Analyzed
        Notes:
        Alias:
        ValidateSet:

    .PARAMETER Walkthrough
        Description:  Start the dynamic help menu system to help walk through the current command and all of the parameters
        Notes:
        Alias: Help
        ValidateSet:

    .EXAMPLE
        Command: Confirm-PSTerraformLikeActionList .\CleanFile.yaml
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

    .EXAMPLE
        Command: Confirm-PSTerraformLikeActionList -Help
        Description: Call Help Information
        Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter

    .EXAMPLE
        Command: Confirm-PSTerraformLikeActionList -WalkThrough
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
    [Alias('Confirm-TFLAL','TFLAL')]
    #region Parameters
    Param
    (
        [Parameter(Position = 0)]
        [String]$Path,

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
                $Info = Get-Content -Path $Path -Raw | ConvertFrom-Yaml

                $Global:Error.Clear()

                foreach ($property in $info.Actions) {
                    $command = $property.keys
                    $parameters = $property[$command]
                    $lookupParams = $(Get-Help -Name $command -ErrorAction SilentlyContinue).parameters.parameter | `
                        Select-Object -ExpandProperty Name

                    Describe "Parameter Validation for [$($command.ToUpper())]" {
                        foreach ($key in $parameters.Keys) {
                            It "Parameter [$($key.ToUpper())] should exist" {
                                $lookupParams | Should -Contain $key
                            }
                        }
                    }
                }

                If (  $Global:Error.Count -gt 0 ) {
                    $HashReturn["$HashName"].Comments  = $Global:Error
                    $HashReturn["$HashName"].Info = [PSCustomObject]@{
                        ValidConfig = $false
                    }
                } Else {
                    $HashReturn["$HashName"].Info = [PSCustomObject]@{
                        ValidConfig = $true
                    }
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