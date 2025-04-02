<#
.SYNOPSIS
    Configures Microsoft Edge delegated authentication schemes for origins.
.DESCRIPTION
    Sets the list of delegated authentication schemes for specific origins in Microsoft Edge.
.PARAMETER Origins
    Specifies an array of origin URLs and their delegated authentication schemes.
.EXAMPLE
    Set-EdgePolicyDelegateAuthSchemesAllowedForOrigins -Origins @{"example.com" = @("Negotiate")}
#>
function Set-EdgePolicyDelegateAuthSchemesAllowedForOrigins {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [hashtable]$Origins
    )

    if ($Origins.Count -gt 0) {
        $settings = @()
        foreach ($origin in $Origins.GetEnumerator()) {
            $settings += "${origin.Key}|${origin.Value -join ','}"
        }
        Set-EdgePolicy -PolicyName "DelegateAuthSchemesAllowedForOrigins" -Type "MultiString" -Value $settings
    }
}
