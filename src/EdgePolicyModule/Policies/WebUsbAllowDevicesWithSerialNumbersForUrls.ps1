<#
.SYNOPSIS
    Configures Microsoft Edge WebUSB device access with serial numbers.
.DESCRIPTION
    Sets the list of sites that can access USB devices with specific serial numbers.
.PARAMETER Devices
    Specifies an array of device configurations in the format "site.com:vendor_id:product_id:serial_number".
.EXAMPLE
    Set-EdgePolicyWebUsbAllowDevicesWithSerialNumbersForUrls -Devices @("example.com:0x1234:0x5678:123", "test.com:0x9ABC:0xDEF0:456")
#>
function Set-EdgePolicyWebUsbAllowDevicesWithSerialNumbersForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Devices
    )

    if ($Devices.Count -gt 0) {
        Set-EdgePolicy -PolicyName "WebUsbAllowDevicesWithSerialNumbersForUrls" -Type "MultiString" -Value $Devices
    }
}
