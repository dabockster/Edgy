<#
.SYNOPSIS
    Configures Microsoft Edge SmartScreen allow list domains.
.DESCRIPTION
    Sets the domains to be allowed in SmartScreen protection.
.PARAMETER Domains
    Specifies an array of domain names to be allowed in SmartScreen protection.
.EXAMPLE
    Set-EdgePolicySmartScreenAllowListDomains -Domains @("example.com", "trusted.com")
#>
function Set-EdgePolicySmartScreenAllowListDomains {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Domains
    )

    if ($Domains.Count -gt 0) {
        Set-EdgePolicy -PolicyName "SmartScreenAllowListDomains" -Type "MultiString" -Value $Domains
    }
}
