<#
.SYNOPSIS
    Configures Microsoft Edge Application Guard favorites sync.
.DESCRIPTION
    Enables or disables favorites synchronization in Application Guard.
.PARAMETER Enabled
    Specifies whether favorites sync is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyApplicationGuardFavoritesSyncEnabled -Enabled $true
#>
function Set-EdgePolicyApplicationGuardFavoritesSyncEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "ApplicationGuardFavoritesSyncEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
