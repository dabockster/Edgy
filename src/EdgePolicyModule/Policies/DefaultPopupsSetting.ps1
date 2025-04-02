<#
.SYNOPSIS
    Configures Microsoft Edge default popups setting.
.DESCRIPTION
    Sets the default behavior for handling popups.
.PARAMETER Setting
    Specifies the popups setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultPopupsSetting -Setting "Block"
#>
function Set-EdgePolicyDefaultPopupsSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Block"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultPopupsSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultPopupsSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultPopupsSetting" -Type "DWord" -Value 0 }
    }
}
