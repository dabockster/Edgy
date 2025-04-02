<#
.SYNOPSIS
    Configures Microsoft Edge Application Guard container proxy.
.DESCRIPTION
    Sets the Application Guard container proxy settings in Microsoft Edge.
.PARAMETER Proxy
    Specifies the Application Guard container proxy settings.
.EXAMPLE
    Set-EdgePolicyApplicationGuardContainerProxy -Proxy "proxy.example.com:8080"
#>
function Set-EdgePolicyApplicationGuardContainerProxy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Proxy
    )

    Set-EdgePolicy -PolicyName "ApplicationGuardContainerProxy" -Type "String" -Value $Proxy
}
