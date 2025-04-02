<#
.SYNOPSIS
    Configures Microsoft Edge distrusted CA certificates.
.DESCRIPTION
    Sets the list of distrusted CA certificates in Microsoft Edge.
.PARAMETER Certificates
    Specifies an array of distrusted CA certificate paths.
.EXAMPLE
    Set-EdgePolicyCADistrustedCertificates -Certificates @("cert1.cer", "cert2.cer")
#>
function Set-EdgePolicyCADistrustedCertificates {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Certificates
    )

    if ($Certificates.Count -gt 0) {
        Set-EdgePolicy -PolicyName "CADistrustedCertificates" -Type "MultiString" -Value $Certificates
    }
}
