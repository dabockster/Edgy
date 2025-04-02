<#
.SYNOPSIS
    Configures Microsoft Edge proxy mode.
.DESCRIPTION
    Sets the proxy mode in Microsoft Edge.
.PARAMETER Mode
    Specifies the proxy mode (Direct, AutoDetect, PacScript, FixedServers).
.EXAMPLE
    Set-EdgePolicyProxyMode -Mode "AutoDetect"
#>
function Set-EdgePolicyProxyMode {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Direct", "AutoDetect", "PacScript", "FixedServers")]
        [string]$Mode = "AutoDetect"
    )

    switch ($Mode) {
        "Direct" { Set-EdgePolicy -PolicyName "ProxyMode" -Type "DWord" -Value 0 }
        "AutoDetect" { Set-EdgePolicy -PolicyName "ProxyMode" -Type "DWord" -Value 1 }
        "PacScript" { Set-EdgePolicy -PolicyName "ProxyMode" -Type "DWord" -Value 2 }
        "FixedServers" { Set-EdgePolicy -PolicyName "ProxyMode" -Type "DWord" -Value 3 }
    }
}
