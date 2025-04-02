<#
.SYNOPSIS
    Configures Microsoft Edge insecure content blocklist.
.DESCRIPTION
    Sets the list of sites where insecure content is blocked.
.PARAMETER Sites
    Specifies an array of site URLs where insecure content is blocked.
.EXAMPLE
    Set-EdgePolicyInsecureContentBlockedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyInsecureContentBlockedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "InsecureContentBlockedForUrls" -Type "MultiString" -Value $Sites
    }
}
