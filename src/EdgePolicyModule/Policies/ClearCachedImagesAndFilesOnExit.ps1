<#
.SYNOPSIS
    Configures Microsoft Edge to clear cached images and files on exit.
.DESCRIPTION
    Enables or disables automatic clearing of cached images and files when Microsoft Edge exits.
.PARAMETER Enabled
    Specifies whether cached images and files are cleared on exit ($true) or not ($false).
.EXAMPLE
    Set-EdgePolicyClearCachedImagesAndFilesOnExit -Enabled $true
#>
function Set-EdgePolicyClearCachedImagesAndFilesOnExit {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "ClearCachedImagesAndFilesOnExit" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
