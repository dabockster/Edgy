<#
.SYNOPSIS
    Configures Microsoft Edge kiosk mode download deletion.
.DESCRIPTION
    Enables or disables automatic deletion of downloads on exit in kiosk mode.
.PARAMETER Enabled
    Specifies whether downloads are automatically deleted on exit ($true) or not ($false).
.EXAMPLE
    Set-EdgePolicyKioskDeleteDownloadsOnExit -Enabled $true
#>
function Set-EdgePolicyKioskDeleteDownloadsOnExit {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "KioskDeleteDownloadsOnExit" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
