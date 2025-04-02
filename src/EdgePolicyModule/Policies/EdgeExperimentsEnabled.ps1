<#
.SYNOPSIS
    Configures Microsoft Edge experiments.
.DESCRIPTION
    Enables or disables Edge experiments.
.PARAMETER Enabled
    Specifies whether Edge experiments are enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyEdgeExperimentsEnabled -Enabled $true
#>
function Set-EdgePolicyEdgeExperimentsEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "EdgeExperimentsEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
