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
    Type of the policy value (String, Integer, Boolean).
.PARAMETER Value
    Value to set for the policy.
.EXAMPLE
    Set-EdgePolicy -PolicyName "SmartScreenEnabled" -Type "Boolean" -Value $true
#>
function Set-EdgePolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$PolicyName,

        [Parameter(Mandatory=$true)]
        [ValidateSet("String", "Integer", "Boolean")]
        [string]$Type,

        [Parameter(Mandatory=$true)]
        $Value
    )

    # Create policy path if it doesn't exist
    New-EdgePolicyPath

    # Validate value type based on policy type
    switch ($Type.ToLower()) {
        'string' {
            if ($Value -isnot [string]) {
                throw "Value for String policy must be a string"
            }
            $registryType = "String"
        }
        'integer' {
            if ($Value -isnot [int]) {
                throw "Value for Integer policy must be an integer"
            }
            $registryType = "DWord"
        }
        'boolean' {
            if ($Value -isnot [bool]) {
                throw "Value for Boolean policy must be a boolean"
            }
            $registryType = "DWord"
            $Value = if ($Value) { 1 } else { 0 }
        }
    }

    Write-Verbose "Setting policy '$PolicyName' with value '$Value'"
    Set-ItemProperty -Path $POLICY_PATH -Name $PolicyName -Value $Value -Type $registryType -Force
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

<#
.SYNOPSIS
    Applies Microsoft Edge policies from a JSON configuration file.
.DESCRIPTION
    Reads a JSON configuration file containing Edge policies and applies them to the registry.
    The JSON file should contain policy metadata and an example value that will be applied.
.PARAMETER JsonPath
    Path to the JSON configuration file.
.PARAMETER Value
    Optional. If specified, overrides the example value from the JSON file.
.EXAMPLE
    Set-EdgePoliciesFromJson -JsonPath "C:\Policies\ApplicationGuard\ApplicationGuardContainerProxy.json"
.EXAMPLE
    # Override the value from JSON with a custom value
    Set-EdgePoliciesFromJson -JsonPath "C:\Policies\ApplicationGuard\ApplicationGuardContainerProxy.json" -Value "{"ProxyMode": "direct"}"
#>
function Set-EdgePoliciesFromJson {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$JsonPath,

        [Parameter(Mandatory=$false)]
        $Value
    )

    if (-not (Test-Path $JsonPath)) {
        throw "Policy file not found: $JsonPath"
    }

    try {
        $policyConfig = Get-Content -Path $JsonPath -Raw | ConvertFrom-Json
    }
    catch {
        throw "Failed to parse JSON file: $_"
    }

    # Get the policy name from the root key
    $policyName = $policyConfig.PSObject.Properties.Name
    $policy = $policyConfig.$policyName

    # Validate required fields
    if (-not $policy.type) {
        throw "Policy configuration is missing required 'type' field"
    }

    # Get the value to apply
    $policyValue = if ($Value) { $Value } else { $policy.'example-value' }
    if (-not $policyValue) {
        throw "No value specified for policy '$policyName'. Please provide a value or use the -Value parameter"
    }

    # Convert value based on type
    switch ($policy.type.ToLower()) {
        'string' {
            $valueToSet = [string]$policyValue
        }
        'integer' {
            $valueToSet = [int]$policyValue
        }
        'boolean' {
            $valueToSet = [bool]$policyValue
        }
        default {
            throw "Unsupported policy type: $($policy.type)"
        }
    }

    try {
        # Apply the policy
        Set-EdgePolicy -PolicyName $policyName -Type $policy.type -Value $valueToSet
        Write-Verbose "Successfully applied policy: $policyName"
    }
    catch {
        Write-Warning "Failed to apply policy '$policyName': $_"
    }
}

<#
.SYNOPSIS
    Gets detailed information about a Microsoft Edge policy.
.DESCRIPTION
    Retrieves detailed information about a Microsoft Edge policy from its JSON configuration.
.PARAMETER JsonPath
    Path to the JSON configuration file.
.EXAMPLE
    Get-EdgePolicyInfo -JsonPath "C:\Policies\ApplicationGuard\ApplicationGuardContainerProxy.json"
#>
function Get-EdgePolicyInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$JsonPath
    )

    if (-not (Test-Path $JsonPath)) {
        throw "Policy file not found: $JsonPath"
    }

    try {
        $policyConfig = Get-Content -Path $JsonPath -Raw | ConvertFrom-Json
        $policyName = $policyConfig.PSObject.Properties.Name
        $policy = $policyConfig.$policyName

        return [PSCustomObject]@{
            Name = $policyName
            Type = $policy.type
            Description = $policy.description
            Requirements = $policy.requirements
            ExampleValue = $policy.'example-value'
            CurrentValue = Get-EdgePolicy -PolicyName $policyName
        }
    }
    catch {
        throw "Failed to get policy information: $_"
    }
}

<#
.SYNOPSIS
    Validates a policy configuration object.
.DESCRIPTION
    Validates that a policy configuration object has all required properties and values.
.PARAMETER Policy
    Policy configuration object to validate.
#>
function Test-PolicyConfiguration {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [PSCustomObject]$Policy
    )

    $requiredProperties = @('Name', 'Type', 'Value')
    foreach ($prop in $requiredProperties) {
        if (-not $Policy.PSObject.Properties.Name.Contains($prop)) {
            throw "Policy configuration is missing required property: $prop"
        }
    }

    if ($Policy.Type -notin @('DWord', 'String', 'MultiString', 'Binary')) {
        throw "Invalid policy type: $($Policy.Type). Must be one of: DWord, String, MultiString, Binary"
    }
}
