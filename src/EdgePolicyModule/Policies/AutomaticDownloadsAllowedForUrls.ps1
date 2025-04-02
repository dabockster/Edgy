<#
.SYNOPSIS
    Configures Microsoft Edge automatic downloads for specific sites.
.DESCRIPTION
    Sets the list of sites where multiple automatic downloads are allowed.
.PARAMETER Sites
    Specifies an array of site URLs where automatic downloads are allowed.
.EXAMPLE
    Set-EdgePolicyAutomaticDownloadsAllowedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyAutomaticDownloadsAllowedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "AutomaticDownloadsAllowedForUrls" -Type "MultiString" -Value $Sites
    }
}
