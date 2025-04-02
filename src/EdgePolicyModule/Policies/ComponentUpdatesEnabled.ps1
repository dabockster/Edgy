<#
.SYNOPSIS
    Configures Microsoft Edge component updates.
.DESCRIPTION
    Enables or disables component updates in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether component updates are enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyComponentUpdatesEnabled -Enabled $true
#>
function Set-EdgePolicyComponentUpdatesEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "ComponentUpdatesEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
