<#
.SYNOPSIS
    Configures Microsoft Edge platform certificate integration.
.DESCRIPTION
    Enables or disables the use of user-added TLS certificates from platform trust stores.
.PARAMETER Enabled
    Specifies whether platform certificate integration is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyCAPlatformIntegrationEnabled -Enabled $true
#>
function Set-EdgePolicyCAPlatformIntegrationEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "CAPlatformIntegrationEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
