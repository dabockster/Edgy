<#
.SYNOPSIS
    Configures Microsoft Edge popups blocklist.
.DESCRIPTION
    Sets the list of sites where popups are blocked.
.PARAMETER Sites
    Specifies an array of site URLs where popups are blocked.
.EXAMPLE
    Set-EdgePolicyPopupsBlockedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyPopupsBlockedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "PopupsBlockedForUrls" -Type "MultiString" -Value $Sites
    }
}
