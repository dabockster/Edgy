<#
.SYNOPSIS
    Configures Microsoft Edge trusted CA certificates with constraints.
.DESCRIPTION
    Sets the list of trusted CA certificates with constraints for server authentication.
.PARAMETER Certificates
    Specifies an array of trusted CA certificate paths with constraints.
.EXAMPLE
    Set-EdgePolicyCACertificatesWithConstraints -Certificates @("cert1.cer", "cert2.cer")
#>
function Set-EdgePolicyCACertificatesWithConstraints {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Certificates
    )

    if ($Certificates.Count -gt 0) {
        Set-EdgePolicy -PolicyName "CACertificatesWithConstraints" -Type "MultiString" -Value $Certificates
    }
}
