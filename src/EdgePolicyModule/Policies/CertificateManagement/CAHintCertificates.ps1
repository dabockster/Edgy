<#
.SYNOPSIS
    Configures Microsoft Edge hint CA certificates.
.DESCRIPTION
    Sets the list of CA certificates that can be used in path-building for server authentication.
.PARAMETER Certificates
    Specifies an array of CA certificate paths for path-building.
.EXAMPLE
    Set-EdgePolicyCAHintCertificates -Certificates @("cert1.cer", "cert2.cer")
#>
function Set-EdgePolicyCAHintCertificates {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Certificates
    )

    if ($Certificates.Count -gt 0) {
        Set-EdgePolicy -PolicyName "CAHintCertificates" -Type "MultiString" -Value $Certificates
    }
}
