<#
.SYNOPSIS
    Configures Microsoft Edge PDF reader.
.DESCRIPTION
    Enables or disables the PDF reader in Microsoft Edge.
.PARAMETER Enabled
    Specifies whether the PDF reader is enabled ($true) or disabled ($false).
.EXAMPLE
    Set-EdgePolicyPDFReaderEnabled -Enabled $true
#>
function Set-EdgePolicyPDFReaderEnabled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true
    )

    Set-EdgePolicy -PolicyName "PDFReaderEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
}
