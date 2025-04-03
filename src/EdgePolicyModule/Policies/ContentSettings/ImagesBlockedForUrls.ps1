<#
.SYNOPSIS
    Configures Microsoft Edge images blocklist.
.DESCRIPTION
    Sets the list of sites where images are blocked.
.PARAMETER Sites
    Specifies an array of site URLs where images are blocked.
.EXAMPLE
    Set-EdgePolicyImagesBlockedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyImagesBlockedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ImagesBlockedForUrls" -Type "MultiString" -Value $Sites
    }
}
