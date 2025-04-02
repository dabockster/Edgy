<#
.SYNOPSIS
    Configures Microsoft Edge JavaScript JIT allow list.
.DESCRIPTION
    Sets the list of sites where JavaScript Just-In-Time compilation is allowed.
.PARAMETER Sites
    Specifies an array of site URLs where JavaScript JIT is allowed.
.EXAMPLE
    Set-EdgePolicyJavaScriptJitAllowedForSites -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyJavaScriptJitAllowedForSites {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "JavaScriptJitAllowedForSites" -Type "MultiString" -Value $Sites
    }
}
