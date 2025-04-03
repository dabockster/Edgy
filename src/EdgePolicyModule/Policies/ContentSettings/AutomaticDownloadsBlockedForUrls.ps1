<#
.SYNOPSIS
    Configures Microsoft Edge automatic downloads blocklist.
.DESCRIPTION
    Sets the list of sites where multiple automatic downloads are blocked.
.PARAMETER Sites
    Specifies an array of site URLs where automatic downloads are blocked.
.EXAMPLE
    Set-EdgePolicyAutomaticDownloadsBlockedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyAutomaticDownloadsBlockedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "AutomaticDownloadsBlockedForUrls" -Type "MultiString" -Value $Sites
    }
}
