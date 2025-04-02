<#
.SYNOPSIS
    Configures Microsoft Edge SmartScreen protection.
.DESCRIPTION
    Enables or disables SmartScreen protection in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether SmartScreen protection is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicySmartScreenEnabled -Enabled $true
#>
function Set-EdgePolicySmartScreenEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "SmartScreenEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
