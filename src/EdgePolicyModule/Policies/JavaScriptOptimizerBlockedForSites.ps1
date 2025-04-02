<#
.SYNOPSIS
    Configures Microsoft Edge JavaScript optimizer blocklist.
.DESCRIPTION
    Sets the list of sites where JavaScript optimization is blocked.
.PARAMETER Sites
    Specifies an array of site URLs where JavaScript optimization is blocked.
.EXAMPLE
    Set-EdgePolicyJavaScriptOptimizerBlockedForSites -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyJavaScriptOptimizerBlockedForSites {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "JavaScriptOptimizerBlockedForSites" -Type "MultiString" -Value $Sites
    }
}
