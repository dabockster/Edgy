<#
.SYNOPSIS
    Configures Microsoft Edge WebHID device access based on HID usage.
.DESCRIPTION
    Sets the list of sites that can access HID devices with specific usage.
.PARAMETER Devices
    Specifies an array of device configurations in the format "site.com:usage_page:usage_id".
.EXAMPLE
    Set-EdgePolicyWebHidAllowDevicesWithHidUsagesForUrls -Devices @("example.com:0x01:0x02", "test.com:0x02:0x03")
#>
function Set-EdgePolicyWebHidAllowDevicesWithHidUsagesForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Devices
    )

    if ($Devices.Count -gt 0) {
        Set-EdgePolicy -PolicyName "WebHidAllowDevicesWithHidUsagesForUrls" -Type "MultiString" -Value $Devices
    }
}
