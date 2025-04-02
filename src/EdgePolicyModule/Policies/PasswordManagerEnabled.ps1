<#
.SYNOPSIS
    Configures Microsoft Edge password manager.
.DESCRIPTION
    Enables or disables the password manager in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether the password manager is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyPasswordManagerEnabled -Enabled $true
#>
function Set-EdgePolicyPasswordManagerEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "PasswordManagerEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
