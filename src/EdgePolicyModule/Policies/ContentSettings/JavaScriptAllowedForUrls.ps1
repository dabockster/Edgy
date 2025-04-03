<#
.SYNOPSIS
    Configures Microsoft Edge JavaScript allow list.
.DESCRIPTION
    Sets the list of sites where JavaScript is allowed.
.PARAMETER Sites
    Specifies an array of site URLs where JavaScript is allowed.
.EXAMPLE
    Set-EdgePolicyJavaScriptAllowedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyJavaScriptAllowedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "JavaScriptAllowedForUrls" -Type "MultiString" -Value $Sites
    }
}
