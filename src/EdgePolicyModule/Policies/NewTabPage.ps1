<#
.SYNOPSIS
    Configures Microsoft Edge New Tab Page settings.
.DESCRIPTION
    Configures various settings related to Microsoft Edge's New Tab Page, including content, location, and quick links.
.PARAMETER EnableNewTabPage
    Enables or disables the New Tab Page.
.PARAMETER NewTabPageLocation
    Specifies a custom location for the New Tab Page.
.PARAMETER ManagedQuickLinks
    Specifies managed quick links to appear on the New Tab Page.
.EXAMPLE
    Configure-NewTabPage -EnableNewTabPage $true -NewTabPageLocation "https://bing.com" -ManagedQuickLinks @("https://microsoft.com", "https://github.com")
#>
function Configure-NewTabPage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$EnableNewTabPage = $true,

        [Parameter(Mandatory=$false)]
        [string]$NewTabPageLocation = "",

        [Parameter(Mandatory=$false)]
        [string[]]$ManagedQuickLinks = @()
    )

    if ($EnableNewTabPage) {
        Set-EdgePolicy -PolicyName "NewTabPageContentEnabled" -Type "DWord" -Value 1
    } else {
        Set-EdgePolicy -PolicyName "NewTabPageContentEnabled" -Type "DWord" -Value 0
    }

    if (-not [string]::IsNullOrEmpty($NewTabPageLocation)) {
        Set-EdgePolicy -PolicyName "NewTabPageLocation" -Type "String" -Value $NewTabPageLocation
    }

    if ($ManagedQuickLinks.Count -gt 0) {
        Set-EdgePolicy -PolicyName "NewTabPageManagedQuickLinks" -Type "MultiString" -Value $ManagedQuickLinks
    }
}
