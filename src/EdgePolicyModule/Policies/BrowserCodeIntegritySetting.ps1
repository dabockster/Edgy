<#
.SYNOPSIS
    Configures Microsoft Edge browser code integrity.
.DESCRIPTION
    Sets the browser code integrity setting in Microsoft Edge.
.PARAMETER Setting
    Specifies the browser code integrity setting (Default, Disabled, Enabled).
.EXAMPLE
    Set-EdgePolicyBrowserCodeIntegritySetting -Setting "Enabled"
#>
function Set-EdgePolicyBrowserCodeIntegritySetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Default", "Disabled", "Enabled")]
        [string]$Setting = "Default"
    )

    switch ($Setting) {
        "Default" { Set-EdgePolicy -PolicyName "BrowserCodeIntegritySetting" -Type "DWord" -Value 0 }
        "Disabled" { Set-EdgePolicy -PolicyName "BrowserCodeIntegritySetting" -Type "DWord" -Value 1 }
        "Enabled" { Set-EdgePolicy -PolicyName "BrowserCodeIntegritySetting" -Type "DWord" -Value 2 }
    }
}
