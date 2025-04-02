<#
.SYNOPSIS
    Configures Microsoft Edge trusted CA certificates.
.DESCRIPTION
    Sets the list of trusted CA certificates in Microsoft Edge.
.PARAMETER Certificates
    Specifies an array of trusted CA certificate paths.
.EXAMPLE
    Set-EdgePolicyCACertificates -Certificates @("cert1.cer", "cert2.cer")
#>
function Set-EdgePolicyCACertificates {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Certificates
    )

    if ($Certificates.Count -gt 0) {
        Set-EdgePolicy -PolicyName "CACertificates" -Type "MultiString" -Value $Certificates
    }
}
