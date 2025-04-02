<#
.SYNOPSIS
    Configures Microsoft Edge scareware blocker protection.
.DESCRIPTION
    Enables or disables scareware blocker protection in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether scareware blocker protection is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyScarewareBlockerProtectionEnabled -Enabled $true
#>
function Set-EdgePolicyScarewareBlockerProtectionEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "ScarewareBlockerProtectionEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
