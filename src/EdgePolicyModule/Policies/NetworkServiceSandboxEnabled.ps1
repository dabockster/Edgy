<#
.SYNOPSIS
    Configures Microsoft Edge network service sandbox.
.DESCRIPTION
    Enables or disables the network service sandbox in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether the network service sandbox is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyNetworkServiceSandboxEnabled -Enabled $true
#>
function Set-EdgePolicyNetworkServiceSandboxEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "NetworkServiceSandboxEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
