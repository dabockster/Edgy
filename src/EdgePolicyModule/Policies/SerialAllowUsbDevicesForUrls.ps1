<#
.SYNOPSIS
    Configures Microsoft Edge USB serial device access.
.DESCRIPTION
    Sets the list of sites that can access USB serial devices.
.PARAMETER Sites
    Specifies an array of site URLs that can access USB serial devices.
.EXAMPLE
    Set-EdgePolicySerialAllowUsbDevicesForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicySerialAllowUsbDevicesForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "SerialAllowUsbDevicesForUrls" -Type "MultiString" -Value $Sites
    }
}
