<#
.SYNOPSIS
    Configures Microsoft Edge notifications blocklist.
.DESCRIPTION
    Sets the list of sites where notifications are blocked.
.PARAMETER Sites
    Specifies an array of site URLs where notifications are blocked.
.EXAMPLE
    Set-EdgePolicyNotificationsBlockedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyNotificationsBlockedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "NotificationsBlockedForUrls" -Type "MultiString" -Value $Sites
    }
}
