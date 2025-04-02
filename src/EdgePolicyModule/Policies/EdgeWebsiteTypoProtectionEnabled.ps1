<#
.SYNOPSIS
    Configures Microsoft Edge website typo protection.
.DESCRIPTION
    Enables or disables website typo protection in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether website typo protection is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyEdgeWebsiteTypoProtectionEnabled -Enabled $true
#>
function Set-EdgePolicyEdgeWebsiteTypoProtectionEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "EdgeWebsiteTypoProtectionEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
