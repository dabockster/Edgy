<#
.SYNOPSIS
    Configures Microsoft Edge default cookies setting.
.DESCRIPTION
    Sets the default cookies setting in Microsoft Edge.
.PARAMETER Setting
    Specifies the cookies setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultCookiesSetting -Setting "Allow"
#>
function Set-EdgePolicyDefaultCookiesSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Allow"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultCookiesSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultCookiesSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultCookiesSetting" -Type "DWord" -Value 3 }
    }
}
