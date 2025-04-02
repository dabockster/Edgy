<#
.SYNOPSIS
    Configures Microsoft Edge WebRTC local IP addresses.
.DESCRIPTION
    Sets the URLs that are allowed to access local IP addresses via WebRTC.
.PARAMETER URLs
    Specifies an array of URLs that are allowed to access local IP addresses.
.EXAMPLE
    Set-EdgePolicyWebRtcLocalIpsAllowedUrls -URLs @("example.com", "work.com")
#>
function Set-EdgePolicyWebRtcLocalIpsAllowedUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$URLs
    )

    if ($URLs.Count -gt 0) {
        Set-EdgePolicy -PolicyName "WebRtcLocalIpsAllowedUrls" -Type "MultiString" -Value $URLs
    }
}
