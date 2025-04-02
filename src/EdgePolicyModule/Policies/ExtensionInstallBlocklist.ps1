<#
.SYNOPSIS
    Configures Microsoft Edge extension installation block list.
.DESCRIPTION
    Sets the list of blocked extension IDs for installation in Microsoft Edge.
.PARAMETER ExtensionIds
    Specifies an array of extension IDs to block installation.
.EXAMPLE
    Set-EdgePolicyExtensionInstallBlocklist -ExtensionIds @("abc123", "def456")
#>
function Set-EdgePolicyExtensionInstallBlocklist {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$ExtensionIds
    )

    if ($ExtensionIds.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallBlocklist" -Type "MultiString" -Value $ExtensionIds
    }
}
