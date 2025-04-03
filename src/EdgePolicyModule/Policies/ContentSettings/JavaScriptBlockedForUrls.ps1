<#
.SYNOPSIS
    Configures Microsoft Edge JavaScript blocklist.
.DESCRIPTION
    Sets the list of sites where JavaScript is blocked.
.PARAMETER Sites
    Specifies an array of site URLs where JavaScript is blocked.
.EXAMPLE
    Set-EdgePolicyJavaScriptBlockedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyJavaScriptBlockedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "JavaScriptBlockedForUrls" -Type "MultiString" -Value $Sites
    }
}
