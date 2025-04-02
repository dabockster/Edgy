<#
.SYNOPSIS
    Configures Microsoft Edge plugins allow list.
.DESCRIPTION
    Sets the list of sites where plugins are allowed (obsolete).
.PARAMETER Sites
    Specifies an array of site URLs where plugins are allowed.
.EXAMPLE
    Set-EdgePolicyPluginsAllowedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyPluginsAllowedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "PluginsAllowedForUrls" -Type "MultiString" -Value $Sites
    }
}
