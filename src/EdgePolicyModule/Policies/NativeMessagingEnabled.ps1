<#
.SYNOPSIS
    Configures Microsoft Edge native messaging.
.DESCRIPTION
    Enables or disables native messaging in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether native messaging is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyNativeMessagingEnabled -Enabled $true
#>
function Set-EdgePolicyNativeMessagingEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "NativeMessagingEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
