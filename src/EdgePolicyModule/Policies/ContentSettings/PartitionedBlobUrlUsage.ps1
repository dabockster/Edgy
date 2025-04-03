<#
.SYNOPSIS
    Configures Microsoft Edge Blob URL partitioning.
.DESCRIPTION
    Controls Blob URL partitioning during fetching and navigation.
.PARAMETER Setting
    Specifies the Blob URL partitioning setting (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyPartitionedBlobUrlUsage -Setting "Ask"
#>
function Set-EdgePolicyPartitionedBlobUrlUsage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Setting = "Ask"
    )

    switch ($Setting) {
        "Allow" { Set-EdgePolicy -PolicyName "PartitionedBlobUrlUsage" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "PartitionedBlobUrlUsage" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "PartitionedBlobUrlUsage" -Type "DWord" -Value 0 }
    }
}
