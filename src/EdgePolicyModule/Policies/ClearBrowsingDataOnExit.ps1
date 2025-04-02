<#
.SYNOPSIS
    Configures Microsoft Edge to clear browsing data on exit.
.DESCRIPTION
    Enables or disables automatic clearing of browsing data when Microsoft Edge exits.
.PARAMETER Enabled
    Specifies whether browsing data is cleared on exit ($true) or not ($false).
.EXAMPLE
    Set-EdgePolicyClearBrowsingDataOnExit -Enabled $true
#>
function Set-EdgePolicyClearBrowsingDataOnExit {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "ClearBrowsingDataOnExit" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
