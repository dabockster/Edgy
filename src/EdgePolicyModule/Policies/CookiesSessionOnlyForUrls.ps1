<#
.SYNOPSIS
    Configures Microsoft Edge session-only cookies for specific sites.
.DESCRIPTION
    Sets the list of sites where cookies are limited to the current session.
.PARAMETER Sites
    Specifies an array of site URLs where cookies are session-only.
.EXAMPLE
    Set-EdgePolicyCookiesSessionOnlyForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyCookiesSessionOnlyForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "CookiesSessionOnlyForUrls" -Type "MultiString" -Value $Sites
    }
}
