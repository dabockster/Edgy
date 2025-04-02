<#
.SYNOPSIS
    Configures Microsoft Edge mouse gesture support.
.DESCRIPTION
    Enables or disables mouse gesture support in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether mouse gestures are enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyMouseGestureEnabled -Enabled $true
#>
function Set-EdgePolicyMouseGestureEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "MouseGestureEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
