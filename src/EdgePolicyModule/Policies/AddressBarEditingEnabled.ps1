<#
.SYNOPSIS
    Configures Microsoft Edge Address Bar editing.
.DESCRIPTION
    Enables or disables editing in the Microsoft Edge address bar.
.PARAMETER Enabled
    Specifies whether address bar editing is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyAddressBarEditingEnabled -Enabled $true
#>
function Set-EdgePolicyAddressBarEditingEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "AddressBarEditingEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
