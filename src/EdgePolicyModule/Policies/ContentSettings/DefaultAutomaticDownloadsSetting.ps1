<#
.SYNOPSIS
    Configures Microsoft Edge default automatic downloads setting.
.DESCRIPTION
    Sets the default behavior for automatic downloads.
.PARAMETER Setting
    Specifies the automatic downloads setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultAutomaticDownloadsSetting -Setting "Ask"
#>
function Set-EdgePolicyDefaultAutomaticDownloadsSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Ask"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultAutomaticDownloadsSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultAutomaticDownloadsSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultAutomaticDownloadsSetting" -Type "DWord" -Value 0 }
    }
}
