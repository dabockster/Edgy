<#
.SYNOPSIS
    Configures Microsoft Edge extension install forcelist.
.DESCRIPTION
    Sets the list of extensions that must be installed in Microsoft Edge.
.PARAMETER Extensions
    Specifies an array of extension IDs and their update URLs.
.EXAMPLE
    Set-EdgePolicyExtensionInstallForcelist -Extensions @{"abc123" = "https://example.com/update"}
#>
function Set-EdgePolicyExtensionInstallForcelist {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [hashtable]$Extensions
    )

    if ($Extensions.Count -gt 0) {
        $settings = @()
        foreach ($extension in $Extensions.GetEnumerator()) {
            $settings += "${extension.Key}|${extension.Value}"
        }
        Set-EdgePolicy -PolicyName "ExtensionInstallForcelist" -Type "MultiString" -Value $settings
    }
}
