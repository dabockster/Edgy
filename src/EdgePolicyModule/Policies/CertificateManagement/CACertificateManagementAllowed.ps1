<#
.SYNOPSIS
    Configures Microsoft Edge certificate management.
.DESCRIPTION
    Enables or disables certificate management in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether certificate management is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyCACertificateManagementAllowed -Enabled $true
#>
function Set-EdgePolicyCACertificateManagementAllowed {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "CACertificateManagementAllowed" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
