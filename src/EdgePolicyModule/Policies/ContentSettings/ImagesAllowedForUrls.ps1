<#
.SYNOPSIS
    Configures Microsoft Edge images allow list.
.DESCRIPTION
    Sets the list of sites where images are allowed.
.PARAMETER Sites
    Specifies an array of site URLs where images are allowed.
.EXAMPLE
    Set-EdgePolicyImagesAllowedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyImagesAllowedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ImagesAllowedForUrls" -Type "MultiString" -Value $Sites
    }
}
