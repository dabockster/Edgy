# EdgePolicyModule

A PowerShell module for managing Microsoft Edge policies via the Windows Registry.

## Features

- Comprehensive Edge policy management
- Organized by policy categories
- PowerShell 7+ compatible
- Full help documentation
- Cmdlet-style functions

## Installation

1. Copy the module to your PowerShell modules path:
   ```powershell
   $modulePath = Join-Path $env:USERPROFILE "Documents\PowerShell\Modules"
   Copy-Item -Path "EdgePolicyModule" -Destination $modulePath -Recurse
   ```

2. Import the module:
   ```powershell
   Import-Module EdgePolicyModule
   ```

## Usage

### Basic Usage

```powershell
# Configure New Tab Page
Configure-NewTabPage -EnableNewTabPage $true -NewTabPageLocation "https://bing.com"

# Set SmartScreen settings
Set-EdgeSmartScreen -Enabled $true -ForTrustedDownloads $true

# Get policy value
Get-EdgePolicy -PolicyName "SmartScreenEnabled"
```

### Help

All cmdlets include full help documentation:

```powershell
Get-Help Configure-NewTabPage -Full
```

## Policy Categories

- New Tab Page
- Address Bar
- Downloads
- SmartScreen
- Privacy
- Performance
- Security
- Extensions
- Content Settings
- PDF Reader
- Proxy
- Default Search Provider
- HTTP Authentication
- Identity and Sign-In

## Requirements

- PowerShell 7.0 or later
- Windows operating system with Microsoft Edge installed

## License

MIT License
