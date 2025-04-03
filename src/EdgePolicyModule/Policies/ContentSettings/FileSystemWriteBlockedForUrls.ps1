<#
.SYNOPSIS
    Configures Microsoft Edge file system write blocklist.
.DESCRIPTION
    Sets the list of sites that are blocked from file system write access.
.PARAMETER Sites
    Specifies an array of site URLs that are blocked from file system write access.
.EXAMPLE
    Set-EdgePolicyFileSystemWriteBlockedForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyFileSystemWriteBlockedForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "FileSystemWriteBlockedForUrls" -Type "MultiString" -Value $Sites
    }
}
