<#
.SYNOPSIS
    Configures Microsoft Edge default JavaScript JIT setting.
.DESCRIPTION
    Sets the default behavior for JavaScript Just-In-Time compilation.
.PARAMETER Setting
    Specifies the JavaScript JIT setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultJavaScriptJitSetting -Setting "Allow"
#>
function Set-EdgePolicyDefaultJavaScriptJitSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Allow"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultJavaScriptJitSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultJavaScriptJitSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultJavaScriptJitSetting" -Type "DWord" -Value 0 }
    }
}
