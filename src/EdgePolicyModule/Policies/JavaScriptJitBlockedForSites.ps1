<#
.SYNOPSIS
    Configures Microsoft Edge JavaScript JIT blocklist.
.DESCRIPTION
    Sets the list of sites where JavaScript Just-In-Time compilation is blocked.
.PARAMETER Sites
    Specifies an array of site URLs where JavaScript JIT is blocked.
.EXAMPLE
    Set-EdgePolicyJavaScriptJitBlockedForSites -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyJavaScriptJitBlockedForSites {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "JavaScriptJitBlockedForSites" -Type "MultiString" -Value $Sites
    }
}
