<#
.SYNOPSIS
    Configures Microsoft Edge related website sets.
.DESCRIPTION
    Enables or disables related website sets in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether related website sets are enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyRelatedWebsiteSetsEnabled -Enabled $true
#>
function Set-EdgePolicyRelatedWebsiteSetsEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "RelatedWebsiteSetsEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
