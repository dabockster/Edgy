<#
.SYNOPSIS
    Configures Microsoft Edge default profile.
.DESCRIPTION
    Enables or disables the default profile in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether the default profile is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyEdgeDefaultProfileEnabled -Enabled $true
#>
function Set-EdgePolicyEdgeDefaultProfileEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "EdgeDefaultProfileEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
