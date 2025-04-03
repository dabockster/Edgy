<#
.SYNOPSIS
    Configures Microsoft Edge notifications allow list.
.DESCRIPTION
    Sets the list of sites where notifications are allowed.
.PARAMETER Sites
    Specifies an array of site URLs where notifications are allowed.
.EXAMPLE
    Set-EdgePolicyNotificationsAllowedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyNotificationsAllowedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "NotificationsAllowedForUrls" -Type "MultiString" -Value $Sites
    }
}
