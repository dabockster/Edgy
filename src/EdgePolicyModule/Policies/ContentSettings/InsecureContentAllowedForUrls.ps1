<#
.SYNOPSIS
    Configures Microsoft Edge insecure content allow list.
.DESCRIPTION
    Sets the list of sites where insecure content is allowed.
.PARAMETER Sites
    Specifies an array of site URLs where insecure content is allowed.
.EXAMPLE
    Set-EdgePolicyInsecureContentAllowedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyInsecureContentAllowedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "InsecureContentAllowedForUrls" -Type "MultiString" -Value $Sites
    }
}
