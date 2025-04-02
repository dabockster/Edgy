<#
.SYNOPSIS
    Configures Microsoft Edge SmartScreen protection for trusted downloads.
.DESCRIPTION
    Enables or disables SmartScreen protection for trusted downloads in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether SmartScreen protection for trusted downloads is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicySmartScreenForTrustedDownloadsEnabled -Enabled $true
#>
function Set-EdgePolicySmartScreenForTrustedDownloadsEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "SmartScreenForTrustedDownloadsEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
