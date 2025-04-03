<#
.SYNOPSIS
    Configures Microsoft Edge default plugins setting.
.DESCRIPTION
    Sets the default behavior for handling plugins (obsolete).
.PARAMETER Setting
    Specifies the plugins setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultPluginsSetting -Setting "Block"
#>
function Set-EdgePolicyDefaultPluginsSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Block"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultPluginsSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultPluginsSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultPluginsSetting" -Type "DWord" -Value 0 }
    }
}
