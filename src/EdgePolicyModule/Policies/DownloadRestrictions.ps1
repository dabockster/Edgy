<#
.SYNOPSIS
    Configures Microsoft Edge download restrictions.
.DESCRIPTION
    Sets the download restrictions level for Microsoft Edge.
.PARAMETER Level
    Specifies the download restrictions level (None, Prompt, Block).
.EXAMPLE
    Set-EdgePolicyDownloadRestrictions -Level "Prompt"
#>
function Set-EdgePolicyDownloadRestrictions {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("None", "Prompt", "Block")]
        [string]$Level = "None"
    )

    switch ($Level) {
        "None" { Set-EdgePolicy -PolicyName "DownloadRestrictions" -Type "DWord" -Value 0 }
        "Prompt" { Set-EdgePolicy -PolicyName "DownloadRestrictions" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DownloadRestrictions" -Type "DWord" -Value 2 }
    }
}
