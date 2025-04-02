<#
.SYNOPSIS
    Configures Microsoft Edge WebHID device access.
.DESCRIPTION
    Sets the list of sites that can access specific HID devices.
.PARAMETER Devices
    Specifies an array of device configurations in the format "site.com:device_id".
.EXAMPLE
    Set-EdgePolicyWebHidAllowDevicesForUrls -Devices @("example.com:device1", "test.com:device2")
#>
function Set-EdgePolicyWebHidAllowDevicesForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Devices
    )

    if ($Devices.Count -gt 0) {
        Set-EdgePolicy -PolicyName "WebHidAllowDevicesForUrls" -Type "MultiString" -Value $Devices
    }
}
