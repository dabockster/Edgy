<#
.SYNOPSIS
    Configures Microsoft Edge third-party storage partitioning blocklist.
.DESCRIPTION
    Sets the list of top-level origins where third-party storage partitioning is blocked.
.PARAMETER Origins
    Specifies an array of top-level origin URLs where third-party storage partitioning is blocked.
.EXAMPLE
    Set-EdgePolicyThirdPartyStoragePartitioningBlockedForOrigins -Origins @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyThirdPartyStoragePartitioningBlockedForOrigins {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Origins
    )

    if ($Origins.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ThirdPartyStoragePartitioningBlockedForOrigins" -Type "MultiString" -Value $Origins
    }
}
