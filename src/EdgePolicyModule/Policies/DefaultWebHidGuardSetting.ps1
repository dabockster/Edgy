<#
.SYNOPSIS
    Configures Microsoft Edge default Web HID guard setting.
.DESCRIPTION
    Sets the default behavior for handling Web HID API.
.PARAMETER Setting
    Specifies the Web HID guard setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultWebHidGuardSetting -Setting "Ask"
#>
function Set-EdgePolicyDefaultWebHidGuardSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Ask"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultWebHidGuardSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultWebHidGuardSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultWebHidGuardSetting" -Type "DWord" -Value 0 }
    }
}
