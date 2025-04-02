<#
.SYNOPSIS
    Configures Microsoft Edge cloud printing URL.
.DESCRIPTION
    Sets the URL for cloud printing in Microsoft Edge.
.PARAMETER URL
    Specifies the URL for cloud printing.
.EXAMPLE
    Set-EdgePolicyCloudPrintURL -URL "https://cloudprint.example.com"
#>
function Set-EdgePolicyCloudPrintURL {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$URL
    )

    Set-EdgePolicy -PolicyName "CloudPrintURL" -Type "String" -Value $URL
}
