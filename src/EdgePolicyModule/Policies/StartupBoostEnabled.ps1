<#
.SYNOPSIS
    Configures Microsoft Edge startup boost.
.DESCRIPTION
    Enables or disables startup boost in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether startup boost is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyStartupBoostEnabled -Enabled $true
#>
function Set-EdgePolicyStartupBoostEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "StartupBoostEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
