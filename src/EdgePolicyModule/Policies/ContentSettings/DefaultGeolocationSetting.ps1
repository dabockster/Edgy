<#
.SYNOPSIS
    Configures Microsoft Edge default geolocation setting.
.DESCRIPTION
    Sets the default behavior for geolocation requests.
.PARAMETER Setting
    Specifies the geolocation setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultGeolocationSetting -Setting "Ask"
#>
function Set-EdgePolicyDefaultGeolocationSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Ask"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultGeolocationSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultGeolocationSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultGeolocationSetting" -Type "DWord" -Value 0 }
    }
}
