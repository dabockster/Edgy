<#
.SYNOPSIS
    Configures Microsoft Edge allowed authentication schemes for origins.
.DESCRIPTION
    Sets the list of allowed authentication schemes for specific origins in Microsoft Edge.
.PARAMETER Origins
    Specifies an array of origin URLs and their allowed authentication schemes.
.EXAMPLE
    Set-EdgePolicyAllAuthSchemesAllowedForOrigins -Origins @{"example.com" = @("Negotiate", "Basic")}
#>
function Set-EdgePolicyAllAuthSchemesAllowedForOrigins {
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
        Set-EdgePolicy -PolicyName "AllAuthSchemesAllowedForOrigins" -Type "MultiString" -Value $settings
    }
}
