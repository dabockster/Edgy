<#
.SYNOPSIS
    Configures Microsoft Edge default browser settings campaign.
.DESCRIPTION
    Enables or disables the default browser settings campaign in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether the default browser settings campaign is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyDefaultBrowserSettingsCampaignEnabled -Enabled $true
#>
function Set-EdgePolicyDefaultBrowserSettingsCampaignEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "DefaultBrowserSettingsCampaignEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
