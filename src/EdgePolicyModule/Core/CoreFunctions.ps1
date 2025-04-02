# CoreFunctions.ps1
# Core functions for EdgePolicyModule

# Define script constants
$SCRIPT_VERSION = "1.0.0"
$POLICY_PATH = "HKLM:\Software\Policies\Microsoft\Edge"

<#
.SYNOPSIS
    Creates the Edge policy registry path if it doesn't exist.
.DESCRIPTION
    Ensures the Edge policy registry path exists for storing policy settings.
.EXAMPLE
    New-EdgePolicyPath
#>
function New-EdgePolicyPath {
    [CmdletBinding()]
    param ()

    if (-not (Test-Path $POLICY_PATH)) {
        Write-Verbose "Creating Edge policy registry path"
        New-Item -Path $POLICY_PATH -Force | Out-Null
    }
}

<#
.SYNOPSIS
    Sets a Microsoft Edge policy value in the registry.
.DESCRIPTION
    Sets a specified policy value in the Microsoft Edge policy registry path.
.PARAMETER PolicyName
    Name of the policy to set.
.PARAMETER Type
    Type of the policy value (DWord, String, MultiString, Binary).
.PARAMETER Value
    Value to set for the policy.
.EXAMPLE
    Set-EdgePolicy -PolicyName "SmartScreenEnabled" -Type "DWord" -Value 1
#>
function Set-EdgePolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$PolicyName,

        [Parameter(Mandatory=$true)]
        [ValidateSet("DWord", "String", "MultiString", "Binary")]
        [string]$Type,

        [Parameter(Mandatory=$true)]
        $Value
    )

    New-EdgePolicyPath

    Write-Verbose "Setting policy '$PolicyName' with value '$Value'"
    Set-ItemProperty -Path $POLICY_PATH -Name $PolicyName -Value $Value -Type $Type -Force
}

<#
.SYNOPSIS
    Removes a Microsoft Edge policy from the registry.
.DESCRIPTION
    Removes a specified policy from the Microsoft Edge policy registry path.
.PARAMETER PolicyName
    Name of the policy to remove.
.EXAMPLE
    Remove-EdgePolicy -PolicyName "SmartScreenEnabled"
#>
function Remove-EdgePolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$PolicyName
    )

    Write-Verbose "Removing policy '$PolicyName'"
    Remove-ItemProperty -Path $POLICY_PATH -Name $PolicyName -ErrorAction SilentlyContinue
}

<#
.SYNOPSIS
    Gets the current value of a Microsoft Edge policy.
.DESCRIPTION
    Retrieves the current value of a specified policy from the Microsoft Edge policy registry path.
.PARAMETER PolicyName
    Name of the policy to retrieve.
.EXAMPLE
    Get-EdgePolicy -PolicyName "SmartScreenEnabled"
#>
function Get-EdgePolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$PolicyName
    )

    if (Test-Path "$POLICY_PATH\$PolicyName") {
        return (Get-ItemProperty -Path $POLICY_PATH -Name $PolicyName).$PolicyName
    }
    return $null
}
