<#
.SYNOPSIS
    Configures Microsoft Edge automatic certificate selection.
.DESCRIPTION
    Sets the list of sites where client certificates should be automatically selected.
.PARAMETER Sites
    Specifies an array of site URLs where automatic certificate selection is enabled.
.EXAMPLE
    Set-EdgePolicyAutoSelectCertificateForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyAutoSelectCertificateForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "AutoSelectCertificateForUrls" -Type "MultiString" -Value $Sites
    }
}
