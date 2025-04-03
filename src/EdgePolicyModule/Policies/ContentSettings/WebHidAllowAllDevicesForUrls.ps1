<#
.SYNOPSIS
    Configures Microsoft Edge WebHID device access.
.DESCRIPTION
    Sets the list of sites that can access any HID device.
.PARAMETER Sites
    Specifies an array of site URLs that can access any HID device.
.EXAMPLE
    Set-EdgePolicyWebHidAllowAllDevicesForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyWebHidAllowAllDevicesForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "WebHidAllowAllDevicesForUrls" -Type "MultiString" -Value $Sites
    }
}
