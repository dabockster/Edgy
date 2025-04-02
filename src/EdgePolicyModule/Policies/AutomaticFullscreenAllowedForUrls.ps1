<#
.SYNOPSIS
    Configures Microsoft Edge automatic fullscreen for specific sites.
.DESCRIPTION
    Sets the list of sites where automatic fullscreen is allowed.
.PARAMETER Sites
    Specifies an array of site URLs where automatic fullscreen is allowed.
.EXAMPLE
    Set-EdgePolicyAutomaticFullscreenAllowedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyAutomaticFullscreenAllowedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "AutomaticFullscreenAllowedForUrls" -Type "MultiString" -Value $Sites
    }
}
