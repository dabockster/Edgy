<#
.SYNOPSIS
    Configures Microsoft Edge to block third-party cookies.
.DESCRIPTION
    Enables or disables blocking of third-party cookies in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether third-party cookies are blocked ($true) or allowed ($false).
.EXAMPLE
    Set-EdgePolicyBlockThirdPartyCookies -Enabled $true
#>
function Set-EdgePolicyBlockThirdPartyCookies {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $false
    )

    Set-EdgePolicy -PolicyName "BlockThirdPartyCookies" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
