<#
.SYNOPSIS
    Configures Microsoft Edge basic authentication over HTTP.
.DESCRIPTION
    Enables or disables basic authentication over HTTP in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether basic authentication over HTTP is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyBasicAuthOverHttpEnabled -Enabled $true
#>
function Set-EdgePolicyBasicAuthOverHttpEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "BasicAuthOverHttpEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
