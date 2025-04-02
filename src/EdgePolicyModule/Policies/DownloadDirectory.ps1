<#
.SYNOPSIS
    Configures Microsoft Edge download directory.
.DESCRIPTION
    Sets the default download directory for Microsoft Edge.
.PARAMETER Path
    Specifies the path to use as the default download directory.
.EXAMPLE
    Set-EdgePolicyDownloadDirectory -Path "C:\Downloads"
#>
function Set-EdgePolicyDownloadDirectory {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    if (-not [string]::IsNullOrEmpty($Path)) {
        Set-EdgePolicy -PolicyName "DownloadDirectory" -Type "String" -Value $Path
    }
}
