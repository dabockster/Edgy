<#
.SYNOPSIS
    Configures Microsoft Edge favorites bar visibility.
.DESCRIPTION
    Enables or disables the favorites bar in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether the favorites bar is visible ($true) or hidden ($false).
.EXAMPLE
    Set-EdgePolicyFavoritesBarEnabled -Enabled $true
#>
function Set-EdgePolicyFavoritesBarEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $false
    )

    Set-EdgePolicy -PolicyName "FavoritesBarEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
