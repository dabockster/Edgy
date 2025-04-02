<#
.SYNOPSIS
    Configures Microsoft Edge default window management setting.
.DESCRIPTION
    Sets the default behavior for window management.
.PARAMETER Setting
    Specifies the default window management setting (0=Block, 1=Allow, 2=Ask).
.EXAMPLE
    Set-EdgePolicyWindowManagementDefaultSetting -Setting 1
#>
function Set-EdgePolicyWindowManagementDefaultSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet(0,1,2)]
        [int]$Setting = 1
    )

    Set-EdgePolicy -PolicyName "WindowManagementDefaultSetting" -Type "DWord" -Value $Setting
}
