<#
.SYNOPSIS
    Configures Microsoft Edge sleeping tabs.
.DESCRIPTION
    Enables or disables sleeping tabs in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether sleeping tabs are enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicySleepingTabsEnabled -Enabled $true
#>
function Set-EdgePolicySleepingTabsEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "SleepingTabsEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
