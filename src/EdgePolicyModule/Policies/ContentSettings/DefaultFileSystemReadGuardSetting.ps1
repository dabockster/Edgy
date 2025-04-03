<#
.SYNOPSIS
    Configures Microsoft Edge default file system read guard setting.
.DESCRIPTION
    Sets the default setting for file system read access.
.PARAMETER Setting
    Specifies the file system read guard setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultFileSystemReadGuardSetting -Setting "Ask"
#>
function Set-EdgePolicyDefaultFileSystemReadGuardSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Ask"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultFileSystemReadGuardSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultFileSystemReadGuardSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultFileSystemReadGuardSetting" -Type "DWord" -Value 0 }
    }
}
