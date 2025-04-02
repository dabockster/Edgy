<#
.SYNOPSIS
    Configures Microsoft Edge Downloads settings.
.DESCRIPTION
    Configures settings related to Microsoft Edge downloads, including download directory and restrictions.
.PARAMETER DownloadDirectory
    Specifies the default download directory.
.PARAMETER Restrictions
    Specifies the download restrictions level (None, Prompt, Block).
.EXAMPLE
    Configure-Downloads -DownloadDirectory "C:\Downloads" -Restrictions "Prompt"
#>
function Configure-Downloads {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]$DownloadDirectory = "",

        [Parameter(Mandatory=$false)]
        [ValidateSet("None", "Prompt", "Block")]
        [string]$Restrictions = "None"
    )

    if (-not [string]::IsNullOrEmpty($DownloadDirectory)) {
        Set-EdgePolicy -PolicyName "DownloadDirectory" -Type "String" -Value $DownloadDirectory
    }

    switch ($Restrictions) {
        "None" { Set-EdgePolicy -PolicyName "DownloadRestrictions" -Type "DWord" -Value 0 }
        "Prompt" { Set-EdgePolicy -PolicyName "DownloadRestrictions" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DownloadRestrictions" -Type "DWord" -Value 2 }
    }
}
