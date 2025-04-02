<#
.SYNOPSIS
    Configures Microsoft Edge Application Guard traffic identification.
.DESCRIPTION
    Enables or disables traffic identification for Application Guard.
.PARAMETER Enabled
    Specifies whether traffic identification is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyApplicationGuardTrafficIdentificationEnabled -Enabled $true
#>
function Set-EdgePolicyApplicationGuardTrafficIdentificationEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "ApplicationGuardTrafficIdentificationEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
