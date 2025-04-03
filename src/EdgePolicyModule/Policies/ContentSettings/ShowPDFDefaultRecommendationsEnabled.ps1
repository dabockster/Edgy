<#
.SYNOPSIS
    Configures Microsoft Edge PDF reader recommendations.
.DESCRIPTION
    Enables or disables notifications to set Microsoft Edge as default PDF reader.
.PARAMETER Enabled
    Specifies whether PDF reader recommendations are enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyShowPDFDefaultRecommendationsEnabled -Enabled $true
#>
function Set-EdgePolicyShowPDFDefaultRecommendationsEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "ShowPDFDefaultRecommendationsEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
