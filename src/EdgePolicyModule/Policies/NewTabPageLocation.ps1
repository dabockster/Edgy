<#
.SYNOPSIS
    Configures Microsoft Edge New Tab Page location.
.DESCRIPTION
    Sets the custom location for the Microsoft Edge New Tab Page.
.PARAMETER Url
    Specifies the URL to use as the New Tab Page location.
.EXAMPLE
    Set-EdgePolicyNewTabPageLocation -Url "https://bing.com"
#>
function Set-EdgePolicyNewTabPageLocation {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Url
    )

    if (-not [string]::IsNullOrEmpty($Url)) {
        Set-EdgePolicy -PolicyName "NewTabPageLocation" -Type "String" -Value $Url
    }
}
