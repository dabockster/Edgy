<#
.SYNOPSIS
    Configures Microsoft Edge automatic fullscreen blocklist.
.DESCRIPTION
    Sets the list of sites where automatic fullscreen is blocked.
.PARAMETER Sites
    Specifies an array of site URLs where automatic fullscreen is blocked.
.EXAMPLE
    Set-EdgePolicyAutomaticFullscreenBlockedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyAutomaticFullscreenBlockedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "AutomaticFullscreenBlockedForUrls" -Type "MultiString" -Value $Sites
    }
}
