<#
.SYNOPSIS
    Configures Microsoft Edge external extension blocking.
.DESCRIPTION
    Enables or disables blocking of external extensions in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether external extensions are blocked ($true) or allowed ($false).
.EXAMPLE
    Set-EdgePolicyBlockExternalExtensions -Enabled $true
#>
function Set-EdgePolicyBlockExternalExtensions {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "BlockExternalExtensions" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
