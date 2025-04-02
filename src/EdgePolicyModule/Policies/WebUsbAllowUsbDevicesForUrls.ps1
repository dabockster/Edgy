<#
.SYNOPSIS
    Configures Microsoft Edge USB device access.
.DESCRIPTION
    Sets the list of sites that can access USB devices.
.PARAMETER Sites
    Specifies an array of site URLs that can access USB devices.
.EXAMPLE
    Set-EdgePolicyWebUsbAllowUsbDevicesForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyWebUsbAllowUsbDevicesForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "WebUsbAllowUsbDevicesForUrls" -Type "MultiString" -Value $Sites
    }
}
