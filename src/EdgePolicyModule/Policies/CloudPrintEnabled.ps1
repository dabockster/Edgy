<#
.SYNOPSIS
    Configures Microsoft Edge cloud printing.
.DESCRIPTION
    Enables or disables cloud printing in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether cloud printing is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyCloudPrintEnabled -Enabled $true
#>
function Set-EdgePolicyCloudPrintEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "CloudPrintEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
