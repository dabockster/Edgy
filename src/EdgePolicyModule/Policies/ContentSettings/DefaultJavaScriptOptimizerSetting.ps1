<#
.SYNOPSIS
    Configures Microsoft Edge default JavaScript optimizer setting.
.DESCRIPTION
    Sets the default behavior for JavaScript optimization.
.PARAMETER Setting
    Specifies the JavaScript optimizer setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultJavaScriptOptimizerSetting -Setting "Allow"
#>
function Set-EdgePolicyDefaultJavaScriptOptimizerSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Allow"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultJavaScriptOptimizerSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultJavaScriptOptimizerSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultJavaScriptOptimizerSetting" -Type "DWord" -Value 0 }
    }
}
