<#
.SYNOPSIS
    Configures Microsoft Edge home button visibility.
.DESCRIPTION
    Enables or disables the home button in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether the home button is visible ($true) or hidden ($false).
.EXAMPLE
    Set-EdgePolicyShowHomeButton -Enabled $true
#>
function Set-EdgePolicyShowHomeButton {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "ShowHomeButton" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
