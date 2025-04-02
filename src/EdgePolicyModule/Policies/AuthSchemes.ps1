<#
.SYNOPSIS
    Configures Microsoft Edge supported authentication schemes.
.DESCRIPTION
    Sets the supported authentication schemes in Microsoft Edge.
.PARAMETER Schemes
    Specifies an array of authentication schemes to support.
.EXAMPLE
    Set-EdgePolicyAuthSchemes -Schemes @("Negotiate", "Basic")
#>
function Set-EdgePolicyAuthSchemes {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Schemes
    )

    if ($Schemes.Count -gt 0) {
        Set-EdgePolicy -PolicyName "AuthSchemes" -Type "MultiString" -Value $Schemes
    }
}
