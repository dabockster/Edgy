<#
.SYNOPSIS
    Configures Microsoft Edge default insecure content setting.
.DESCRIPTION
    Sets the default behavior for handling insecure content.
.PARAMETER Setting
    Specifies the insecure content setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultInsecureContentSetting -Setting "Block"
#>
function Set-EdgePolicyDefaultInsecureContentSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Block"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultInsecureContentSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultInsecureContentSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultInsecureContentSetting" -Type "DWord" -Value 0 }
    }
}
