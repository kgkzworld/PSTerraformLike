#region New-PSTerraformLikeRunBook (Function)
Function New-PSTerraformLikeRunBook
{
<#
    .SYNOPSIS
        New-PSTerraformLikeRunBook will create a new PSTerraformLike RunBook template.

        Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and declarative manner.
                Terraform is not required to use this module.

    .DESCRIPTION
        New-PSTerraformLikeRunBook will create a new PSTerraformLike RunBook template.

        Note:  PSTerraformLike is a PowerShell module that will allow you to run PowerShell commands in a Terraform and declarative manner.
                Terraform is not required to use this module.

    .PARAMETER Path
        Description: Full path to the filename to be created
        Notes: If you do not select a path, the file will be created in the current directory and the current date will be used as the filename
                Example: .\RunBook_11.29.2023_6.35.39_PM.YAML
        Alias:
        ValidateSet:

    .PARAMETER Walkthrough
        Description:  Start the dynamic help menu system to help walk through the current command and all of the parameters
        Notes:
        Alias: Help
        ValidateSet:

    .EXAMPLE
        Command: New-PSTerraformLikeRunBook
        Description: This will create a new PSTerraformLike RunBook template in the current directory with the current date as the filename
        Notes:
        Output:

    .EXAMPLE
        Command: New-PSTerraformLikeRunBook -Path 'C:\Temp\MyRunBook.yaml'
        Description: This will create a new PSTerraformLike RunBook template in the C:\Temp directory with the filename of MyRunBook.yaml
        Notes:
        Output:

    .EXAMPLE
        Command: New-PSTerraformLikeRunBook -Help
        Description: Call Help Information
        Notes: If Help / WalkThrough is setup as a parameter, this script will be called to setup the Dynamic Help Menu if not the normal Get-Help will be called with the -Full parameter

    .EXAMPLE
        Command: New-PSTerraformLikeRunBook -WalkThrough
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
    [Alias('New-TFLRB','TFLNRB')]
    #region Parameters
    Param
    (
        [Parameter(Position = 0)]
        [String]$Path = $('.\RunBook_{0}.yaml' -f $(Get-Date).ToString() -replace '/|:','.' -replace '\s+','_'),

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
                Write-Verbose 'Main work in Process block'

                #region Script Block Execution Check
                    If ( -Not $fprocess ) {
                        #Clean Exit (Do not process anything further)
                        Return
                    }
                #endregion Script Block Execution Check

                #region Main Code
                    #region Config Properties
                        $Config = @{}
                        $Config.Title = 'RunBook Template Title'
                        $Config.Description = 'RunBook Template Description'
                        $Config.Version = $( '1.0.0.{0}' -f $(Get-Date -Format yyyyMMdd).ToString() )
                        $Config.Author = "$env:username"
                        $Config.Run = @{}
                        $Config.Run.OnBuild = '.*'
                        $Config.Run.OncpuArch = 'AMD64'
                        $Config.Run.OnOSName = '.*Windows.*'
                        $Config.Run.OnProductType = '1'
                    #endregion Config Properties

                    #region Create the Actions Array
                        $Actions =  @()
                        $Actions += $(ConvertTo-PSTerraformLikeAction -Command Write-Host | ConvertFrom-Yaml).Actions
                        $Actions += $(ConvertTo-PSTerraformLikeAction -Command Get-ChildItem | ConvertFrom-Yaml).Actions
                    #endregion Create the Actions Array

                    #region Create the object with the nested arrays
                        $ParentObject = @{
                            Config = $Config
                            Actions = $Actions
                        }
                    #region Create the object with the nested arrays

                    #region Add the object to the HashReturn
                        $HashReturn["$HashName"].Info += $ParentObject
                        Remove-Variable -Name ActionObject -Force -ErrorAction Ignore | Out-Null
                    #endregion Add the object to the HashReturn
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
                    If ($VerbosePreference -eq 'Continue') {
                        Return $HashReturn
                    } Else {
                        Try {
                            $($HashReturn["$HashName"].Info  | ConvertTo-Yaml) | Set-Content -Path $Path -Force -ErrorAction Stop
                        } Catch {
                            Write-Warning -Message "Unable to write to file: $Path"
                            Return $($HashReturn["$HashName"].Info  | ConvertTo-Yaml)
                        }

                    }
                #endregion Output Type
            #endregion Output
        }
    #endregion end
}
#endregion Get-BluGenieSystemInfo (Function)