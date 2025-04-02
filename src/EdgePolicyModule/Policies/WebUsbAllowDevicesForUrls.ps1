<#
.SYNOPSIS
    Configures Microsoft Edge WebUSB device access.
.DESCRIPTION
    Sets the list of sites that can access specific USB devices.
.PARAMETER Devices
    Specifies an array of device configurations in the format "site.com:vendor_id:product_id".
.EXAMPLE
    Set-EdgePolicyWebUsbAllowDevicesForUrls -Devices @("example.com:0x1234:0x5678", "test.com:0x9ABC:0xDEF0")
#>
function Set-EdgePolicyWebUsbAllowDevicesForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Devices
    )

    if ($Devices.Count -gt 0) {
        Set-EdgePolicy -PolicyName "WebUsbAllowDevicesForUrls" -Type "MultiString" -Value $Devices
    }
}
