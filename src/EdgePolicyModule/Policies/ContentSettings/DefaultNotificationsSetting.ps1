<#
.SYNOPSIS
    Configures Microsoft Edge default notifications setting.
.DESCRIPTION
    Sets the default behavior for handling notifications.
.PARAMETER Setting
    Specifies the notifications setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultNotificationsSetting -Setting "Ask"
#>
function Set-EdgePolicyDefaultNotificationsSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Ask"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultNotificationsSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultNotificationsSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultNotificationsSetting" -Type "DWord" -Value 0 }
    }
}
