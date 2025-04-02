<#
.SYNOPSIS
    Configures Microsoft Edge default third-party storage partitioning setting.
.DESCRIPTION
    Sets the default behavior for third-party storage partitioning.
.PARAMETER Setting
    Specifies the third-party storage partitioning setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyDefaultThirdPartyStoragePartitioningSetting -Setting "Allow"
#>
function Set-EdgePolicyDefaultThirdPartyStoragePartitioningSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Allow"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultThirdPartyStoragePartitioningSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultThirdPartyStoragePartitioningSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultThirdPartyStoragePartitioningSetting" -Type "DWord" -Value 0 }
    }
}
