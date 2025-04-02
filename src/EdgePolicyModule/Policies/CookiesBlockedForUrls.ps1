<#
.SYNOPSIS
    Configures Microsoft Edge cookie blocklist.
.DESCRIPTION
    Sets the list of sites where cookies are blocked.
.PARAMETER Sites
    Specifies an array of site URLs where cookies are blocked.
.EXAMPLE
    Set-EdgePolicyCookiesBlockedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyCookiesBlockedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "CookiesBlockedForUrls" -Type "MultiString" -Value $Sites
    }
}
