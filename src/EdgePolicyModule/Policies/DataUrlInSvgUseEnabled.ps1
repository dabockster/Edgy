<#
.SYNOPSIS
    Configures Microsoft Edge SVG data URL support.
.DESCRIPTION
    Enables or disables data URL support for SVGUseElement.
.PARAMETER Enabled
    Specifies whether data URL support is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyDataUrlInSvgUseEnabled -Enabled $true
#>
function Set-EdgePolicyDataUrlInSvgUseEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "DataUrlInSvgUseEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
