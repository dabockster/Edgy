<#
.SYNOPSIS
    Configures Microsoft Edge JavaScript optimizer allow list.
.DESCRIPTION
    Sets the list of sites where JavaScript optimization is allowed.
.PARAMETER Sites
    Specifies an array of site URLs where JavaScript optimization is allowed.
.EXAMPLE
    Set-EdgePolicyJavaScriptOptimizerAllowedForSites -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyJavaScriptOptimizerAllowedForSites {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "JavaScriptOptimizerAllowedForSites" -Type "MultiString" -Value $Sites
    }
}
