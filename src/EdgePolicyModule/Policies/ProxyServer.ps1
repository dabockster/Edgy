<#
.SYNOPSIS
    Configures Microsoft Edge proxy server.
.DESCRIPTION
    Sets the proxy server configuration in Microsoft Edge.
.PARAMETER Server
    Specifies the proxy server configuration (e.g., "proxy.example.com:8080").
.EXAMPLE
    Set-EdgePolicyProxyServer -Server "proxy.example.com:8080"
#>
function Set-EdgePolicyProxyServer {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Server
    )

    Set-EdgePolicy -PolicyName "ProxyServer" -Type "String" -Value $Server
}
