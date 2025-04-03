<#
.SYNOPSIS
    Configures Microsoft Edge file system write ask list.
.DESCRIPTION
    Sets the list of sites that can ask for file system write access.
.PARAMETER Sites
    Specifies an array of site URLs that can ask for file system write access.
.EXAMPLE
    Set-EdgePolicyFileSystemWriteAskForUrls -Sites @("https://example.com", "https://test.com")
#>
function Set-EdgePolicyFileSystemWriteAskForUrls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sites
    )

    if ($Sites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "FileSystemWriteAskForUrls" -Type "MultiString" -Value $Sites
    }
}
