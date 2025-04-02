<#
.SYNOPSIS
    Configures Microsoft Edge file system read blocklist.
.DESCRIPTION
    Sets the list of sites that are blocked from file system read access.
.PARAMETER Sites
    Specifies an array of site URLs that are blocked from file system read access.
.EXAMPLE
    Set-EdgePolicyFileSystemReadBlockedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyFileSystemReadBlockedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "FileSystemReadBlockedForUrls" -Type "MultiString" -Value $Sites
    }
}
