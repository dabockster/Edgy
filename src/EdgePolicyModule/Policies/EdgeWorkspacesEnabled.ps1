<#
.SYNOPSIS
    Configures Microsoft Edge workspaces.
.DESCRIPTION
    Enables or disables Edge workspaces.
.PARAMETER Enabled
    Specifies whether Edge workspaces are enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyEdgeWorkspacesEnabled -Enabled $true
#>
function Set-EdgePolicyEdgeWorkspacesEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "EdgeWorkspacesEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
