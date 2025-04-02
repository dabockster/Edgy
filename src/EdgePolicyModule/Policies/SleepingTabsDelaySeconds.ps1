<#
.SYNOPSIS
    Configures Microsoft Edge sleeping tabs delay.
.DESCRIPTION
    Sets the delay in seconds before tabs go to sleep in Microsoft Edge.
.PARAMETER Delay
    Specifies the delay in seconds before tabs go to sleep.
.EXAMPLE
    Set-EdgePolicySleepingTabsDelaySeconds -Delay 300
#>
function Set-EdgePolicySleepingTabsDelaySeconds {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [int]$Delay = 300
    )

    Set-EdgePolicy -PolicyName "SleepingTabsDelaySeconds" -Type "DWord" -Value $Delay
}
