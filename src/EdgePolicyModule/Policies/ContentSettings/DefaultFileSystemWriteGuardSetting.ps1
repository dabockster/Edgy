<#
.SYNOPSIS
    Configures Microsoft Edge default file system write guard setting.
.DESCRIPTION
    Sets the default setting for file system write access.
.PARAMETER Setting
    Specifies the file system write guard setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultFileSystemWriteGuardSetting -Setting "Ask"
#>
function Set-EdgePolicyDefaultFileSystemWriteGuardSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Ask"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultFileSystemWriteGuardSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultFileSystemWriteGuardSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultFileSystemWriteGuardSetting" -Type "DWord" -Value 0 }
    }
}
