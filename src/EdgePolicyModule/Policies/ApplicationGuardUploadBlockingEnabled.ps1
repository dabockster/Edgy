<#
.SYNOPSIS
    Configures Microsoft Edge Application Guard upload blocking.
.DESCRIPTION
    Enables or disables file upload blocking in Application Guard.
.PARAMETER Enabled
    Specifies whether file upload blocking is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyApplicationGuardUploadBlockingEnabled -Enabled $true
#>
function Set-EdgePolicyApplicationGuardUploadBlockingEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "ApplicationGuardUploadBlockingEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
