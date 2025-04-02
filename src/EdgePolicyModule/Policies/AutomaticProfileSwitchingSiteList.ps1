<#
.SYNOPSIS
    Configures Microsoft Edge automatic profile switching site list.
.DESCRIPTION
    Sets the list of sites that trigger automatic profile switching in Microsoft Edge.
.PARAMETER Sites
    Specifies an array of site URLs that trigger automatic profile switching.
.EXAMPLE
    Set-EdgePolicyAutomaticProfileSwitchingSiteList -Sites @("example.com", "work.com")
#>
function Set-EdgePolicyAutomaticProfileSwitchingSiteList {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "AutomaticProfileSwitchingSiteList" -Type "MultiString" -Value $Sites
    }
}
