<#
.SYNOPSIS
    Configures Microsoft Edge cast icon visibility.
.DESCRIPTION
    Controls whether the cast icon is shown in the toolbar.
.PARAMETER Enabled
    Specifies whether the cast icon is shown ($true) or hidden ($false).
.EXAMPLE
    Set-EdgePolicyShowCastIconInToolbar -Enabled $true
#>
function Set-EdgePolicyShowCastIconInToolbar {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "ShowCastIconInToolbar" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
