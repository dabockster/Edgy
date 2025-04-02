<#
.SYNOPSIS
    Configures Microsoft Edge spotlight experiences.
.DESCRIPTION
    Enables or disables customized background images, suggestions, notifications, and tips for Microsoft services.
.PARAMETER Enabled
    Specifies whether spotlight experiences are enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicySpotlightExperiencesAndRecommendationsEnabled -Enabled $true
#>
function Set-EdgePolicySpotlightExperiencesAndRecommendationsEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "SpotlightExperiencesAndRecommendationsEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
