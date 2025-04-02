<#
.SYNOPSIS
    Configures Microsoft Edge casting.
.DESCRIPTION
    Enables or disables casting in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether casting is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyCastEnabled -Enabled $true
#>
function Set-EdgePolicyCastEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "CastEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
