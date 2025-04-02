<#
.SYNOPSIS
    Configures Microsoft Edge password protection.
.DESCRIPTION
    Enables or disables password protection in Microsoft Edge.
.PARAMETER Allowed
    Specifies whether password protection is allowed ($true) or not ($false).
.EXAMPLE
    Set-EdgePolicyPasswordProtectionAllowed -Allowed $true
#>
function Set-EdgePolicyPasswordProtectionAllowed {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Allowed = $true
    )

    Set-EdgePolicy -PolicyName "PasswordProtectionAllowed" -Type "DWord" -Value ($Allowed ? 1 : 0)
}
