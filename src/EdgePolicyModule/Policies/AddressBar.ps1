<#
.SYNOPSIS
    Configures Microsoft Edge Address Bar settings.
.DESCRIPTION
    Configures settings related to the Microsoft Edge Address Bar, including editing and search functionality.
.PARAMETER EnableEditing
    Enables or disables address bar editing.
.PARAMETER EnableMicrosoftSearch
    Enables or disables Microsoft Search in Bing integration.
.EXAMPLE
    Configure-AddressBar -EnableEditing $true -EnableMicrosoftSearch $true
#>
function Configure-AddressBar {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$EnableEditing = $true,

        [Parameter(Mandatory=$false)]
        [bool]$EnableMicrosoftSearch = $true
    )

    Set-EdgePolicy -PolicyName "AddressBarEditingEnabled" -Type "DWord" -Value ($EnableEditing ? 1 : 0)
    Set-EdgePolicy -PolicyName "AddressBarMicrosoftSearchInBingProviderEnabled" -Type "DWord" -Value ($EnableMicrosoftSearch ? 1 : 0)
}
