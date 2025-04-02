<#
.SYNOPSIS
    Configures Microsoft Edge Application Guard passive mode.
.DESCRIPTION
    Enables or disables passive mode in Application Guard, allowing normal browsing.
.PARAMETER Enabled
    Specifies whether passive mode is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyApplicationGuardPassiveModeEnabled -Enabled $true
#>
function Set-EdgePolicyApplicationGuardPassiveModeEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "ApplicationGuardPassiveModeEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
