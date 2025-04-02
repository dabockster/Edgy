<#
.SYNOPSIS
    Configures Microsoft Edge default search provider URL.
.DESCRIPTION
    Sets the URL of the default search provider in Microsoft Edge.
.PARAMETER URL
    Specifies the URL of the default search provider.
.EXAMPLE
    Set-EdgePolicyDefaultSearchProviderURL -URL "https://www.google.com/search?q={searchTerms}"
#>
function Set-EdgePolicyDefaultSearchProviderURL {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$URL
    )

    Set-EdgePolicy -PolicyName "DefaultSearchProviderURL" -Type "String" -Value $URL
}
