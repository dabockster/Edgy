<#
.SYNOPSIS
    Configures Microsoft Edge New Tab Page managed quick links.
.DESCRIPTION
    Sets the managed quick links to appear on the Microsoft Edge New Tab Page.
.PARAMETER Links
    Specifies an array of URLs to use as managed quick links.
.EXAMPLE
    Set-EdgePolicyNewTabPageManagedQuickLinks -Links @("https://microsoft.com", "https://github.com")
#>
function Set-EdgePolicyNewTabPageManagedQuickLinks {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Links
    )

    if ($Links.Count -gt 0) {
        Set-EdgePolicy -PolicyName "NewTabPageManagedQuickLinks" -Type "MultiString" -Value $Links
    }
}
