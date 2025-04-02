<#
.SYNOPSIS
    Configures Microsoft Edge default JavaScript setting.
.DESCRIPTION
    Sets the default JavaScript setting in Microsoft Edge.
.PARAMETER Setting
    Specifies the JavaScript setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultJavaScriptSetting -Setting "Allow"
#>
function Set-EdgePolicyDefaultJavaScriptSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Allow"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultJavaScriptSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultJavaScriptSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultJavaScriptSetting" -Type "DWord" -Value 3 }
    }
}
