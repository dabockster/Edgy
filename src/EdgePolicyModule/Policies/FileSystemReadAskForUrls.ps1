<#
.SYNOPSIS
    Configures Microsoft Edge file system read ask list.
.DESCRIPTION
    Sets the list of sites that can ask for file system read access.
.PARAMETER Sites
    Specifies an array of site URLs that can ask for file system read access.
.EXAMPLE
    Set-EdgePolicyFileSystemReadAskForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyFileSystemReadAskForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "FileSystemReadAskForUrls" -Type "MultiString" -Value $Sites
    }
}
