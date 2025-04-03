<#
.SYNOPSIS
    Configures Microsoft Edge window management blocklist.
.DESCRIPTION
    Sets the list of sites that cannot manage windows.
.PARAMETER Sites
    Specifies an array of site URLs that cannot manage windows.
.EXAMPLE
    Set-EdgePolicyWindowManagementBlockedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyWindowManagementBlockedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "WindowManagementBlockedForUrls" -Type "MultiString" -Value $Sites
    }
}
