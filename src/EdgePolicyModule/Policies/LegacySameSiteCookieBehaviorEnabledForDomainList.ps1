<#
.SYNOPSIS
    Configures Microsoft Edge legacy SameSite cookie behavior for specific domains.
.DESCRIPTION
    Sets the list of domains where legacy SameSite cookie behavior is enabled (obsolete).
.PARAMETER Domains
    Specifies an array of domain names where legacy SameSite cookie behavior is enabled.
.EXAMPLE
    Set-EdgePolicyLegacySameSiteCookieBehaviorEnabledForDomainList -Domains @("example.com", "test.com")
#>
function Set-EdgePolicyLegacySameSiteCookieBehaviorEnabledForDomainList {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Domains
    )

    if ($Domains.Count -gt 0) {
        Set-EdgePolicy -PolicyName "LegacySameSiteCookieBehaviorEnabledForDomainList" -Type "MultiString" -Value $Domains
    }
}
