<#
.SYNOPSIS
    Configures Microsoft Edge private network request policy.
.DESCRIPTION
    Sets the policy for private network requests in Microsoft Edge.
.PARAMETER Policy
    Specifies the private network request policy (Allow, Block, Ask).
.EXAMPLE
    Set-EdgePolicyPrivateNetworkRequestPolicy -Policy "Block"
#>
function Set-EdgePolicyPrivateNetworkRequestPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$Policy = "Allow"
    )

    switch ($Policy) {
        "Allow" { Set-EdgePolicy -PolicyName "PrivateNetworkRequestPolicy" -Type "DWord" -Value 0 }
        "Block" { Set-EdgePolicy -PolicyName "PrivateNetworkRequestPolicy" -Type "DWord" -Value 1 }
        "Ask" { Set-EdgePolicy -PolicyName "PrivateNetworkRequestPolicy" -Type "DWord" -Value 2 }
    }
}
