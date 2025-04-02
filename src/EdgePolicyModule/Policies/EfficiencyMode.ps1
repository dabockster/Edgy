<#
.SYNOPSIS
    Configures Microsoft Edge efficiency mode level.
.DESCRIPTION
    Sets the efficiency mode level in Microsoft Edge.
.PARAMETER Level
    Specifies the efficiency mode level (Low, Medium, High).
.EXAMPLE
    Set-EdgePolicyEfficiencyMode -Level "Medium"
#>
function Set-EdgePolicyEfficiencyMode {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Low", "Medium", "High")]
        [string]$Level = "Medium"
    )

    switch ($Level) {
        "Low" { Set-EdgePolicy -PolicyName "EfficiencyMode" -Type "DWord" -Value 1 }
        "Medium" { Set-EdgePolicy -PolicyName "EfficiencyMode" -Type "DWord" -Value 2 }
        "High" { Set-EdgePolicy -PolicyName "EfficiencyMode" -Type "DWord" -Value 3 }
    }
}
