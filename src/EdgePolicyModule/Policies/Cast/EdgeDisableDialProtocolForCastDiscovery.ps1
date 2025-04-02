<#
.SYNOPSIS
    Configures Microsoft Edge DIAL protocol for cast device discovery.
.DESCRIPTION
    Enables or disables the DIAL protocol for discovering cast devices.
.PARAMETER Enabled
    Specifies whether DIAL protocol is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyEdgeDisableDialProtocolForCastDiscovery -Enabled $true
#>
function Set-EdgePolicyEdgeDisableDialProtocolForCastDiscovery {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "EdgeDisableDialProtocolForCastDiscovery" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
