<#
.SYNOPSIS
    Configures Microsoft Edge default browser setting.
.DESCRIPTION
    Enables or disables the default browser setting in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether the default browser setting is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyDefaultBrowserSettingEnabled -Enabled $true
#>
function Set-EdgePolicyDefaultBrowserSettingEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "DefaultBrowserSettingEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
