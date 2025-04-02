<#
.SYNOPSIS
    Configures Microsoft Search in Bing integration for Microsoft Edge address bar.
.DESCRIPTION
    Enables or disables Microsoft Search in Bing integration in the Microsoft Edge address bar.
.PARAMETER Enabled
    Specifies whether Microsoft Search in Bing integration is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyAddressBarMicrosoftSearchInBingProviderEnabled -Enabled $true
#>
function Set-EdgePolicyAddressBarMicrosoftSearchInBingProviderEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "AddressBarMicrosoftSearchInBingProviderEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
