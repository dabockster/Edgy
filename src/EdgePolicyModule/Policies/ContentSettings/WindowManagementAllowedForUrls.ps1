<#
.SYNOPSIS
    Configures Microsoft Edge window management allow list.
.DESCRIPTION
    Sets the list of sites that can manage windows.
.PARAMETER Sites
    Specifies an array of site URLs that can manage windows.
.EXAMPLE
    Set-EdgePolicyWindowManagementAllowedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyWindowManagementAllowedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "WindowManagementAllowedForUrls" -Type "MultiString" -Value $Sites
    }
}
