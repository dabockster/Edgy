<#
.SYNOPSIS
    Configures Microsoft Edge immersive reader.
.DESCRIPTION
    Enables or disables the immersive reader in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether the immersive reader is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyImmersiveReaderEnabled -Enabled $true
#>
function Set-EdgePolicyImmersiveReaderEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "ImmersiveReaderEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
