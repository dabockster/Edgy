<#
.SYNOPSIS
    Configures Microsoft Edge network prediction settings.
.DESCRIPTION
    Sets the network prediction options in Microsoft Edge.
.PARAMETER Option
    Specifies the network prediction option (Default, Disabled, Enabled).
.EXAMPLE
    Set-EdgePolicyNetworkPredictionOptions -Option "Enabled"
#>
function Set-EdgePolicyNetworkPredictionOptions {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Default", "Disabled", "Enabled")]
        [string]$Option = "Default"
    )

    switch ($Option) {
        "Default" { Set-EdgePolicy -PolicyName "NetworkPredictionOptions" -Type "DWord" -Value 0 }
        "Disabled" { Set-EdgePolicy -PolicyName "NetworkPredictionOptions" -Type "DWord" -Value 1 }
        "Enabled" { Set-EdgePolicy -PolicyName "NetworkPredictionOptions" -Type "DWord" -Value 2 }
    }
}
