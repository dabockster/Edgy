<#
.SYNOPSIS
    Configures Microsoft Edge serial port access.
.DESCRIPTION
    Sets the list of sites that can access all serial ports.
.PARAMETER Sites
    Specifies an array of site URLs that can access all serial ports.
.EXAMPLE
    Set-EdgePolicySerialAllowAllPortsForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicySerialAllowAllPortsForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "SerialAllowAllPortsForUrls" -Type "MultiString" -Value $Sites
    }
}
