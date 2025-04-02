<#
.SYNOPSIS
    Configures Microsoft Edge default search provider name.
.DESCRIPTION
    Sets the name of the default search provider in Microsoft Edge.
.PARAMETER Name
    Specifies the name of the default search provider.
.EXAMPLE
    Set-EdgePolicyDefaultSearchProviderName -Name "Google"
#>
function Set-EdgePolicyDefaultSearchProviderName {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Name
    )

    Set-EdgePolicy -PolicyName "DefaultSearchProviderName" -Type "String" -Value $Name
}
