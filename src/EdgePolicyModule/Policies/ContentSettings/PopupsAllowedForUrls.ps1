<#
.SYNOPSIS
    Configures Microsoft Edge popups allow list.
.DESCRIPTION
    Sets the list of sites where popups are allowed.
.PARAMETER Sites
    Specifies an array of site URLs where popups are allowed.
.EXAMPLE
    Set-EdgePolicyPopupsAllowedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyPopupsAllowedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "PopupsAllowedForUrls" -Type "MultiString" -Value $Sites
    }
}
