<#
.SYNOPSIS
    Configures Microsoft Edge proxy PAC URL.
.DESCRIPTION
    Sets the URL of the PAC script in Microsoft Edge.
.PARAMETER URL
    Specifies the URL of the PAC script.
.EXAMPLE
    Set-EdgePolicyProxyPacUrl -URL "http://example.com/proxy.pac"
#>
function Set-EdgePolicyProxyPacUrl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$URL
    )

    Set-EdgePolicy -PolicyName "ProxyPacUrl" -Type "String" -Value $URL
}
