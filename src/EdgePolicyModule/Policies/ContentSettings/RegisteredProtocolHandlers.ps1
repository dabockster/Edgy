<#
.SYNOPSIS
    Configures Microsoft Edge protocol handlers.
.DESCRIPTION
    Registers protocol handlers for specific sites.
.PARAMETER Handlers
    Specifies an array of protocol handler configurations in the format "protocol://site.com".
.EXAMPLE
    Set-EdgePolicyRegisteredProtocolHandlers -Handlers @("mailto://example.com", "tel://example.com")
#>
function Set-EdgePolicyRegisteredProtocolHandlers {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Handlers
    )

    if ($Handlers.Count -gt 0) {
        Set-EdgePolicy -PolicyName "RegisteredProtocolHandlers" -Type "MultiString" -Value $Handlers
    }
}
