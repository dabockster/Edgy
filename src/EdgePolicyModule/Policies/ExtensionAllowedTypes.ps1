<#
.SYNOPSIS
    Configures Microsoft Edge allowed extension types.
.DESCRIPTION
    Sets the list of allowed extension types in Microsoft Edge.
.PARAMETER Types
    Specifies an array of allowed extension types.
.EXAMPLE
    Set-EdgePolicyExtensionAllowedTypes -Types @("Extension", "Theme")
#>
function Set-EdgePolicyExtensionAllowedTypes {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Types
    )

    if ($Types.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionAllowedTypes" -Type "MultiString" -Value $Types
    }
}
