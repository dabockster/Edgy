# Edgy - The Microsoft Edge Policy Configurator
# Version: 1.0
# Released: 2025-04-01

# Import the EdgePolicyModule
Import-Module -Name (Join-Path $PSScriptRoot "EdgePolicyModule") -Force

# Script constants
$SCRIPT_VERSION = "1.0"
$RELEASE_DATE = "2025-04-01"
$POLICY_PATH = "HKLM:\Software\Policies\Microsoft\Edge"

# Function to count enabled policies
function Get-EnabledPolicyCount {
    if (Test-Path $POLICY_PATH) {
        return (Get-ChildItem $POLICY_PATH -ErrorAction SilentlyContinue).Count
    }
    return 0
}

# Function to display the main menu
function Show-MainMenu {
    Clear-Host
    Write-Host "`nEdgy - The Microsoft Edge Policy Configurator"
    Write-Host "Version $SCRIPT_VERSION"
    Write-Host "Released $RELEASE_DATE"
    Write-Host "=============================="
    
    Write-Host "`nScanning for enabled Edge policies..."
    $enabledPolicies = Get-EnabledPolicyCount
    Write-Host "You have $enabledPolicies enabled policies.`n"
    
    Write-Host "MAIN MENU"
    Write-Host "========="
    Write-Host "1) Enable/Disable Policies"
    Write-Host "2) List Currently Enabled Policies"
    Write-Host "3) Open Microsoft's Documentation"
    Write-Host "4) DISABLE ALL POLICIES (CLEAN UNINSTALL)"
    Write-Host "5) Exit this script"
    
    Write-Host "`nPlease make a selection: " -NoNewline
    $selection = Read-Host
    return $selection
}

# Function to list enabled policies
function List-EnabledPolicies {
    Clear-Host
    Write-Host "`nENABLED POLICIES"
    Write-Host "==============="
    
    if (Test-Path $POLICY_PATH) {
        $policies = Get-ChildItem $POLICY_PATH
        if ($policies.Count -eq 0) {
            Write-Host "No policies are currently enabled."
        }
        else {
            foreach ($policy in $policies) {
                $value = Get-EdgePolicy -PolicyName $policy.Name
                Write-Host "$($policy.Name): $value"
            }
        }
    }
    else {
        Write-Host "No policies are currently enabled."
    }
    
    Write-Host "`nPress any key to return to main menu..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Function to open documentation
function Open-Documentation {
    Start-Process "https://learn.microsoft.com/en-us/deployedge/microsoft-edge-policies"
    Write-Host "`nDocumentation opened in your default browser."
    Write-Host "Press any key to return to main menu..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Function to clean uninstall
function Clean-Uninstall {
    Clear-Host
    Write-Host "`nWARNING: This will remove ALL Edge policies."
    Write-Host "This action cannot be undone."
    Write-Host "`nAre you sure you want to proceed? (Y/N): " -NoNewline
    $confirmation = Read-Host
    
    if ($confirmation -eq "Y" -or $confirmation -eq "y") {
        if (Test-Path $POLICY_PATH) {
            Remove-Item -Path $POLICY_PATH -Recurse -Force
            Write-Host "`nAll policies have been removed."
        }
        else {
            Write-Host "`nNo policies were found to remove."
        }
    }
    else {
        Write-Host "`nOperation cancelled."
    }
    
    Write-Host "Press any key to return to main menu..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Function to enable/disable policies
function Enable-Disable-Policies {
    Clear-Host
    Write-Host "`nENABLE/DISABLE POLICIES"
    Write-Host "==================="
    
    if (Test-Path $POLICY_PATH) {
        $policies = Get-ChildItem $POLICY_PATH
        if ($policies.Count -eq 0) {
            Write-Host "No policies are currently enabled."
        }
        else {
            foreach ($policy in $policies) {
                $value = Get-EdgePolicy -PolicyName $policy.Name
                Write-Host "$($policy.Name): $value"
            }
        }
    }
    else {
        Write-Host "No policies are currently enabled."
    }
    
    Write-Host "`nPlease select a policy to enable/disable: " -NoNewline
    $policySelection = Read-Host
    
    if (Test-Path (Join-Path $POLICY_PATH $policySelection)) {
        $value = Get-EdgePolicy -PolicyName $policySelection
        if ($value -eq 1) {
            Set-EdgePolicy -PolicyName $policySelection -Value 0
            Write-Host "`nPolicy $policySelection has been disabled."
        }
        else {
            Set-EdgePolicy -PolicyName $policySelection -Value 1
            Write-Host "`nPolicy $policySelection has been enabled."
        }
    }
    else {
        Write-Host "`nPolicy $policySelection not found."
    }
    
    Write-Host "Press any key to return to main menu..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Main script execution
$selection = Show-MainMenu

while ($selection -ne "5") {
    switch ($selection) {
        "1" { Enable-Disable-Policies }
        "2" { List-EnabledPolicies }
        "3" { Open-Documentation }
        "4" { Clean-Uninstall }
        default {
            Write-Host "`nInvalid selection. Please try again."
            Start-Sleep -Seconds 2
        }
    }
    $selection = Show-MainMenu
}

Write-Host "`nThank you for using Edgy! Goodbye!"
Write-Host "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
