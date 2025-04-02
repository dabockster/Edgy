<#
.SYNOPSIS
    Configures Microsoft Edge management.
.DESCRIPTION
    Enables or disables Microsoft Edge management.
.PARAMETER Enabled
    Specifies whether Microsoft Edge management is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyEdgeManagementEnabled -Enabled $true
#>
function Set-EdgePolicyEdgeManagementEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "EdgeManagementEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
