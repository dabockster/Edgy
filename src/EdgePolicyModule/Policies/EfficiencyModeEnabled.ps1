<#
.SYNOPSIS
    Configures Microsoft Edge efficiency mode.
.DESCRIPTION
    Enables or disables efficiency mode in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether efficiency mode is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyEfficiencyModeEnabled -Enabled $true
#>
function Set-EdgePolicyEfficiencyModeEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "EfficiencyModeEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
