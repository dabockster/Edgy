<#
.SYNOPSIS
    Configures Microsoft Edge default window management setting.
.DESCRIPTION
    Sets the default behavior for window management permissions.
.PARAMETER Setting
    Specifies the window management setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultWindowManagementSetting -Setting "Ask"
#>
function Set-EdgePolicyDefaultWindowManagementSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Ask"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultWindowManagementSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultWindowManagementSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultWindowManagementSetting" -Type "DWord" -Value 0 }
    }
}
