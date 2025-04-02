<#
.SYNOPSIS
    Configures Microsoft Edge New Tab Page content.
.DESCRIPTION
    Enables or disables content on the Microsoft Edge New Tab Page.
.PARAMETER Enabled
    Specifies whether New Tab Page content is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyNewTabPageContentEnabled -Enabled $true
#>
function Set-EdgePolicyNewTabPageContentEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "NewTabPageContentEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
