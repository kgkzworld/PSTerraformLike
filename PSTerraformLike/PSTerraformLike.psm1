#region Build Notes
<#
    o 1.0.0.20231129
        [Michael Arroyo] Initial Post
#>
#endregion Build Notes

#region Main
    #region Create Hash
        $PSTerraformLikeInfo = @{}
    #endregion Create Hash

    #region Script File and Path Values
        $PSTerraformLikeInfo['PSScriptRoot'] = $PSScriptRoot

        If ( $PSTerraformLikeInfo['PSScriptRoot'] -eq '' ) {
            If ( $Host.Name -match 'ISE' ) {
                $PSTerraformLikeInfo['PSScriptRoot'] = Split-Path -Path $psISE.CurrentFile.FullPath -Parent
            }
        }
    #endregion Script File and Path Values

    #region Script Settings Values
        $PSTerraformLikeInfo['ScriptSettings'] = @{}
        $PSTerraformLikeInfo['ScriptSettings']['TimeStamp'] = $('D{0}' -f $(Get-Date -Format dd.MM.yyyy-hh.mm.ss.ff.tt)) -replace '-','_T'
        $PSTerraformLikeInfo['ScriptSettings']['CurrentUser'] = $($env:USERNAME)
        $PSTerraformLikeInfo['ScriptSettings']['CurrentComputer'] = $env:COMPUTERNAME.ToUpper()
        $PSTerraformLikeInfo['ScriptSettings']['WorkingPath'] = $PSTerraformLikeInfo.PSScriptRoot
        $PSTerraformLikeInfo['ScriptSettings']['LoadedFunctionsPrv'] = @()
        $PSTerraformLikeInfo['ScriptSettings']['LoadedFunctionsPub'] = @()
        $PSTerraformLikeInfo['ScriptSettings']['LoadedVariablesPub'] = @()
        $PSTerraformLikeInfo['ScriptSettings']['LoadedAliasesPub'] = @()
        $PSTerraformLikeInfo['ScriptSettings']['Log'] = @()
    #endregion Script Settings Values

    #region Query Private Functions
        $PSTerraformLikePrivate = Get-ChildItem -Path $(Join-Path -Path $($PSTerraformLikeInfo.ScriptSettings.Workingpath) -ChildPath 'Private') -Filter '*.ps1' -Force -Recurse -ErrorAction SilentlyContinue | Select-Object -Property BaseName,FullName
    #endregion Query Core Path

    #region Query Public Functions
        $PSTerraformLikePublic = Get-ChildItem -Path $(Join-Path -Path $($PSTerraformLikeInfo.ScriptSettings.Workingpath) -ChildPath 'Public') -Filter '*.ps1' -Force -Recurse -ErrorAction SilentlyContinue | Select-Object -Property BaseName,FullName
    #endregion Query Core Path

    #region Dynamically Build Functions from .PS1 files
        If ( $PSTerraformLikePrivate ) {
            $PSTerraformLikePrivate | ForEach-Object -Process {
                Try {
                    . $($_ | Select-Object -ExpandProperty FullName)
                    $PSTerraformLikeInfo['ScriptSettings']['LoadedFunctionsPrv'] += $($_ | Select-Object -ExpandProperty BaseName)
                } Catch {
                    #Nothing
                }
            }
        }

        If ( $PSTerraformLikePublic ) {
            $PSTerraformLikePublic | ForEach-Object -Process {
                Try {
                    . $($_ | Select-Object -ExpandProperty FullName)
                    $PSTerraformLikeInfo['ScriptSettings']['LoadedFunctionsPub'] += $($_ | Select-Object -ExpandProperty BaseName)
                } Catch {
                    #Nothing
                }
            }
        }
    #endregion Dynamically Build Functions from .PS1 files

    #region Dynamically Build Export Variable list
        $PSTerraformLikeInfo['ScriptSettings']['LoadedVariablesPub'] += 'PSTerraformLikeInfo'
    #endregion Dynamically Build Export Variable list

    #region Export Module Members
        Export-ModuleMember `
        -Function $($PSTerraformLikeInfo['ScriptSettings']['LoadedFunctionsPub']) `
        -Variable $($PSTerraformLikeInfo['ScriptSettings']['LoadedVariablesPub']) `
        #-Alias $($BluGenieInfo['ScriptSettings']['LoadedAliases'] | Select-Object -ExpandProperty Name)
    #endregion Export Module Members
#endregion Main