<#
.SYNOPSIS
    Configures Microsoft Edge WebUSB device access based on USB class.
.DESCRIPTION
    Sets the list of sites that can access USB devices with specific USB class.
.PARAMETER Devices
    Specifies an array of device configurations in the format "site.com:class:subclass:protocol".
.EXAMPLE
    Set-EdgePolicyWebUsbAllowDevicesWithUsbClassesForUrls -Devices @("example.com:0x01:0x02:0x03", "test.com:0x04:0x05:0x06")
#>
function Set-EdgePolicyWebUsbAllowDevicesWithUsbClassesForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Devices
    )

    if ($Devices.Count -gt 0) {
        Set-EdgePolicy -PolicyName "WebUsbAllowDevicesWithUsbClassesForUrls" -Type "MultiString" -Value $Devices
    }
}
