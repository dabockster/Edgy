<#
.SYNOPSIS
    Configures Microsoft Edge extension install blocklist exceptions.
.DESCRIPTION
    Sets the list of exceptions to the extension install blocklist in Microsoft Edge.
.PARAMETER Exceptions
    Specifies an array of exception patterns for the extension install blocklist.
.EXAMPLE
    Set-EdgePolicyExtensionInstallBlocklistExceptions -Exceptions @("*.example.com", "specific-extension-id")
#>
function Set-EdgePolicyExtensionInstallBlocklistExceptions {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Exceptions
    )

    if ($Exceptions.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallBlocklistExceptions" -Type "MultiString" -Value $Exceptions
    }
}
