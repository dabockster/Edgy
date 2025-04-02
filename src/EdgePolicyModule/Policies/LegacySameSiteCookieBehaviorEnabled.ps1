<#
.SYNOPSIS
    Configures Microsoft Edge legacy SameSite cookie behavior.
.DESCRIPTION
    Enables or disables the default legacy SameSite cookie behavior (obsolete).
.PARAMETER Enabled
    Specifies whether legacy SameSite cookie behavior is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyLegacySameSiteCookieBehaviorEnabled -Enabled $true
#>
function Set-EdgePolicyLegacySameSiteCookieBehaviorEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "LegacySameSiteCookieBehaviorEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
