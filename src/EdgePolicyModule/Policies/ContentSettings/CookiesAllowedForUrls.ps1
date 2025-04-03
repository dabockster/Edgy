<#
.SYNOPSIS
    Configures Microsoft Edge cookie permissions for specific sites.
.DESCRIPTION
    Sets the list of sites where cookies are allowed.
.PARAMETER Sites
    Specifies an array of site URLs where cookies are allowed.
.EXAMPLE
    Set-EdgePolicyCookiesAllowedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyCookiesAllowedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "CookiesAllowedForUrls" -Type "MultiString" -Value $Sites
    }
}
