<#
.SYNOPSIS
    Configures Microsoft Edge screen casting.
.DESCRIPTION
    Enables or disables screen casting in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether screen casting is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyCastScreenEnabled -Enabled $true
#>
function Set-EdgePolicyCastScreenEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "CastScreenEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
