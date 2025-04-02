<#
.SYNOPSIS
    Configures Microsoft Edge Google Cast.
.DESCRIPTION
    Enables or disables Google Cast functionality in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether Google Cast is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyEnableMediaRouter -Enabled $true
#>
function Set-EdgePolicyEnableMediaRouter {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "EnableMediaRouter" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
