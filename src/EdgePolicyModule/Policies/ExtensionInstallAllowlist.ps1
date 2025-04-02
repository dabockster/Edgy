<#
.SYNOPSIS
    Configures Microsoft Edge extension installation allow list.
.DESCRIPTION
    Sets the list of allowed extension IDs for installation in Microsoft Edge.
.PARAMETER ExtensionIds
    Specifies an array of extension IDs to allow installation.
.EXAMPLE
    Set-EdgePolicyExtensionInstallAllowlist -ExtensionIds @("abc123", "def456")
#>
function Set-EdgePolicyExtensionInstallAllowlist {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$ExtensionIds
    )

    if ($ExtensionIds.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallAllowlist" -Type "MultiString" -Value $ExtensionIds
    }
}
