<#
.SYNOPSIS
    Configures Microsoft Edge default Web Bluetooth guard setting.
.DESCRIPTION
    Sets the default behavior for handling Web Bluetooth API.
.PARAMETER Setting
    Specifies the Web Bluetooth guard setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultWebBluetoothGuardSetting -Setting "Ask"
#>
function Set-EdgePolicyDefaultWebBluetoothGuardSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Ask"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultWebBluetoothGuardSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultWebBluetoothGuardSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultWebBluetoothGuardSetting" -Type "DWord" -Value 0 }
    }
}
