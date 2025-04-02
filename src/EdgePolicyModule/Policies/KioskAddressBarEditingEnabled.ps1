<#
.SYNOPSIS
    Configures Microsoft Edge kiosk mode address bar editing.
.DESCRIPTION
    Enables or disables address bar editing in kiosk mode in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether address bar editing is enabled ($true) or disabled ($false) in kiosk mode.
.EXAMPLE
    Set-EdgePolicyKioskAddressBarEditingEnabled -Enabled $true
#>
function Set-EdgePolicyKioskAddressBarEditingEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "KioskAddressBarEditingEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
