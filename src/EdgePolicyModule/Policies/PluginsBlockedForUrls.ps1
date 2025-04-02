<#
.SYNOPSIS
    Configures Microsoft Edge plugins blocklist.
.DESCRIPTION
    Sets the list of sites where plugins are blocked (obsolete).
.PARAMETER Sites
    Specifies an array of site URLs where plugins are blocked.
.EXAMPLE
    Set-EdgePolicyPluginsBlockedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyPluginsBlockedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "PluginsBlockedForUrls" -Type "MultiString" -Value $Sites
    }
}
