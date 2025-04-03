<#
.SYNOPSIS
    Configures Microsoft Edge default Web USB guard setting.
.DESCRIPTION
    Sets the default behavior for handling Web USB API.
.PARAMETER Setting
    Specifies the Web USB guard setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultWebUsbGuardSetting -Setting "Ask"
#>
function Set-EdgePolicyDefaultWebUsbGuardSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Ask"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultWebUsbGuardSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultWebUsbGuardSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultWebUsbGuardSetting" -Type "DWord" -Value 0 }
    }
}
