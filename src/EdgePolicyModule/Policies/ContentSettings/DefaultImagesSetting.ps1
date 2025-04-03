<#
.SYNOPSIS
    Configures Microsoft Edge default images setting.
.DESCRIPTION
    Sets the default behavior for loading images.
.PARAMETER Setting
    Specifies the images setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultImagesSetting -Setting "Allow"
#>
function Set-EdgePolicyDefaultImagesSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Allow"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultImagesSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultImagesSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultImagesSetting" -Type "DWord" -Value 0 }
    }
}
