<#
.SYNOPSIS
    Configures Microsoft Edge intranet file links.
.DESCRIPTION
    Enables or disables intranet zone file URL links that open in Windows File Explorer.
.PARAMETER Enabled
    Specifies whether intranet file links are enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyIntranetFileLinksEnabled -Enabled $true
#>
function Set-EdgePolicyIntranetFileLinksEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "IntranetFileLinksEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
