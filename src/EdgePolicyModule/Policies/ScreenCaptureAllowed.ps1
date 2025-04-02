<#
.SYNOPSIS
    Configures Microsoft Edge screen capture.
.DESCRIPTION
    Enables or disables screen capture in Microsoft Edge.
.PARAMETER Allowed
    Specifies whether screen capture is allowed ($true) or blocked ($false).
.EXAMPLE
    Set-EdgePolicyScreenCaptureAllowed -Allowed $true
#>
function Set-EdgePolicyScreenCaptureAllowed {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Allowed = $true
    )

    Set-EdgePolicy -PolicyName "ScreenCaptureAllowed" -Type "DWord" -Value ($Allowed ? 1 : 0)
}
