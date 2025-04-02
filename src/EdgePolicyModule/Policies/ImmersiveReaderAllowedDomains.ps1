<#
.SYNOPSIS
    Configures Microsoft Edge immersive reader allowed domains.
.DESCRIPTION
    Sets the domains that are allowed to use the immersive reader in Microsoft Edge.
.PARAMETER Domains
    Specifies an array of domains that are allowed to use the immersive reader.
.EXAMPLE
    Set-EdgePolicyImmersiveReaderAllowedDomains -Domains @("example.com", "work.com")
#>
function Set-EdgePolicyImmersiveReaderAllowedDomains {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Domains
    )

    if ($Domains.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ImmersiveReaderAllowedDomains" -Type "MultiString" -Value $Domains
    }
}
