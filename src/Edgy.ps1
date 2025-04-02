# Edgy - Microsoft Edge Policy Management Script
# Version: 1.0.0
# Author: [Your Name]
# Description: PowerShell script to manage Microsoft Edge policies via the registry

# Import required modules
Import-Module -Name Microsoft.PowerShell.Management -ErrorAction SilentlyContinue

# Define script constants
$SCRIPT_VERSION = "1.0.0"
$POLICY_PATH = "HKLM:\Software\Policies\Microsoft\Edge"

# Function to create policy registry path if it doesn't exist
function New-EdgePolicyPath {
    if (-not (Test-Path $POLICY_PATH)) {
        Write-Verbose "Creating Edge policy registry path"
        New-Item -Path $POLICY_PATH -Force | Out-Null
    }
}

# Function to set a policy value
function Set-EdgePolicy {
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

# Function to remove a policy
function Remove-EdgePolicy {
    param (
        [Parameter(Mandatory=$true)]
        [string]$PolicyName
    )

    Write-Verbose "Removing policy '$PolicyName'"
    Remove-ItemProperty -Path $POLICY_PATH -Name $PolicyName -ErrorAction SilentlyContinue
}

# Function to get current policy value
function Get-EdgePolicy {
    param (
        [Parameter(Mandatory=$true)]
        [string]$PolicyName
    )

    if (Test-Path "$POLICY_PATH\$PolicyName") {
        return (Get-ItemProperty -Path $POLICY_PATH -Name $PolicyName).$PolicyName
    }
    return $null
}

# Function to configure New Tab Page policies
function Configure-NewTabPage {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$EnableNewTabPage = $true,

        [Parameter(Mandatory=$false)]
        [string]$NewTabPageLocation = "",

        [Parameter(Mandatory=$false)]
        [string[]]$ManagedQuickLinks = @()
    )

    if ($EnableNewTabPage) {
        Set-EdgePolicy -PolicyName "NewTabPageContentEnabled" -Type "DWord" -Value 1
    } else {
        Set-EdgePolicy -PolicyName "NewTabPageContentEnabled" -Type "DWord" -Value 0
    }

    if (-not [string]::IsNullOrEmpty($NewTabPageLocation)) {
        Set-EdgePolicy -PolicyName "NewTabPageLocation" -Type "String" -Value $NewTabPageLocation
    }

    if ($ManagedQuickLinks.Count -gt 0) {
        Set-EdgePolicy -PolicyName "NewTabPageManagedQuickLinks" -Type "MultiString" -Value $ManagedQuickLinks
    }
}

# Function to configure Address Bar policies
function Configure-AddressBar {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$EnableEditing = $true,

        [Parameter(Mandatory=$false)]
        [bool]$EnableMicrosoftSearch = $true
    )

    Set-EdgePolicy -PolicyName "AddressBarEditingEnabled" -Type "DWord" -Value ($EnableEditing ? 1 : 0)
    Set-EdgePolicy -PolicyName "AddressBarMicrosoftSearchInBingProviderEnabled" -Type "DWord" -Value ($EnableMicrosoftSearch ? 1 : 0)
}

# Function to configure Downloads policies
function Configure-Downloads {
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

# Function to configure SmartScreen settings
function Set-EdgeSmartScreen {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$ForTrustedDownloads = $true,

        [Parameter(Mandatory=$false)]
        [string[]]$AllowListDomains = @()
    )

    Set-EdgePolicy -PolicyName "SmartScreenEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "SmartScreenForTrustedDownloadsEnabled" -Type "DWord" -Value ($ForTrustedDownloads ? 1 : 0)

    if ($AllowListDomains.Count -gt 0) {
        Set-EdgePolicy -PolicyName "SmartScreenAllowListDomains" -Type "MultiString" -Value $AllowListDomains
    }
}

# Function to configure Privacy settings
function Set-EdgePrivacy {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$ClearBrowsingDataOnExit = $true,

        [Parameter(Mandatory=$false)]
        [bool]$ClearCachedImagesAndFilesOnExit = $true,

        [Parameter(Mandatory=$false)]
        [bool]$BlockThirdPartyCookies = $false
    )

    Set-EdgePolicy -PolicyName "ClearBrowsingDataOnExit" -Type "DWord" -Value ($ClearBrowsingDataOnExit ? 1 : 0)
    Set-EdgePolicy -PolicyName "ClearCachedImagesAndFilesOnExit" -Type "DWord" -Value ($ClearCachedImagesAndFilesOnExit ? 1 : 0)
    Set-EdgePolicy -PolicyName "BlockThirdPartyCookies" -Type "DWord" -Value ($BlockThirdPartyCookies ? 1 : 0)
}

# Function to configure Performance settings
function Set-EdgePerformance {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$EfficiencyModeEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$StartupBoostEnabled = $true,

        [Parameter(Mandatory=$false)]
        [ValidateSet("Low", "Medium", "High")]
        [string]$EfficiencyMode = "Medium"
    )

    Set-EdgePolicy -PolicyName "EfficiencyModeEnabled" -Type "DWord" -Value ($EfficiencyModeEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "StartupBoostEnabled" -Type "DWord" -Value ($StartupBoostEnabled ? 1 : 0)

    switch ($EfficiencyMode) {
        "Low" { Set-EdgePolicy -PolicyName "EfficiencyMode" -Type "DWord" -Value 1 }
        "Medium" { Set-EdgePolicy -PolicyName "EfficiencyMode" -Type "DWord" -Value 2 }
        "High" { Set-EdgePolicy -PolicyName "EfficiencyMode" -Type "DWord" -Value 3 }
    }
}

# Function to configure UI settings
function Set-EdgeUI {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$ShowHomeButton = $true,

        [Parameter(Mandatory=$false)]
        [bool]$FavoritesBarEnabled = $false,

        [Parameter(Mandatory=$false)]
        [bool]$MouseGestureEnabled = $true
    )

    Set-EdgePolicy -PolicyName "ShowHomeButton" -Type "DWord" -Value ($ShowHomeButton ? 1 : 0)
    Set-EdgePolicy -PolicyName "FavoritesBarEnabled" -Type "DWord" -Value ($FavoritesBarEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "MouseGestureEnabled" -Type "DWord" -Value ($MouseGestureEnabled ? 1 : 0)
}

# Function to configure Startup settings
function Set-EdgeStartup {
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Default", "LastSession", "SpecificURLs")]
        [string]$RestoreOnStartup = "Default",

        [Parameter(Mandatory=$false)]
        [string[]]$StartupURLs = @()
    )

    switch ($RestoreOnStartup) {
        "Default" { Set-EdgePolicy -PolicyName "RestoreOnStartup" -Type "DWord" -Value 0 }
        "LastSession" { Set-EdgePolicy -PolicyName "RestoreOnStartup" -Type "DWord" -Value 1 }
        "SpecificURLs" {
            Set-EdgePolicy -PolicyName "RestoreOnStartup" -Type "DWord" -Value 4
            if ($StartupURLs.Count -gt 0) {
                Set-EdgePolicy -PolicyName "RestoreOnStartupURLs" -Type "MultiString" -Value $StartupURLs
            }
        }
    }
}

# Function to configure Proxy settings
function Set-EdgeProxy {
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Direct", "AutoDetect", "PacScript", "FixedServers")]
        [string]$Mode = "AutoDetect",

        [Parameter(Mandatory=$false)]
        [string]$Server = "",

        [Parameter(Mandatory=$false)]
        [string]$PacUrl = "",

        [Parameter(Mandatory=$false)]
        [string[]]$BypassList = @()
    )

    switch ($Mode) {
        "Direct" { Set-EdgePolicy -PolicyName "ProxyMode" -Type "String" -Value "direct" }
        "AutoDetect" { Set-EdgePolicy -PolicyName "ProxyMode" -Type "String" -Value "auto_detect" }
        "PacScript" {
            Set-EdgePolicy -PolicyName "ProxyMode" -Type "String" -Value "pac_script"
            if (-not [string]::IsNullOrEmpty($PacUrl)) {
                Set-EdgePolicy -PolicyName "ProxyPacUrl" -Type "String" -Value $PacUrl
            }
        }
        "FixedServers" {
            Set-EdgePolicy -PolicyName "ProxyMode" -Type "String" -Value "fixed_servers"
            if (-not [string]::IsNullOrEmpty($Server)) {
                Set-EdgePolicy -PolicyName "ProxyServer" -Type "String" -Value $Server
            }
        }
    }

    if ($BypassList.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ProxyBypassList" -Type "MultiString" -Value $BypassList
    }
}

# Function to configure Security settings
function Set-EdgeSecurity {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$EnhanceSecurityMode = $true,

        [Parameter(Mandatory=$false)]
        [bool]$SmartScreenEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$BlockThirdPartyCookies = $true,

        [Parameter(Mandatory=$false)]
        [string[]]$BypassListDomains = @()
    )

    Set-EdgePolicy -PolicyName "EnhanceSecurityMode" -Type "DWord" -Value ($EnhanceSecurityMode ? 1 : 0)
    Set-EdgePolicy -PolicyName "SmartScreenEnabled" -Type "DWord" -Value ($SmartScreenEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "BlockThirdPartyCookies" -Type "DWord" -Value ($BlockThirdPartyCookies ? 1 : 0)

    if ($BypassListDomains.Count -gt 0) {
        Set-EdgePolicy -PolicyName "EnhanceSecurityModeBypassListDomains" -Type "MultiString" -Value $BypassListDomains
    }
}

# Function to configure Content settings
function Set-EdgeContent {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$JavaScriptEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$ImagesEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$PopupsEnabled = $true,

        [Parameter(Mandatory=$false)]
        [string[]]$JavaScriptBlocklist = @()
    )

    Set-EdgePolicy -PolicyName "DefaultJavaScriptSetting" -Type "DWord" -Value ($JavaScriptEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "DefaultImagesSetting" -Type "DWord" -Value ($ImagesEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "DefaultPopupsSetting" -Type "DWord" -Value ($PopupsEnabled ? 1 : 0)

    if ($JavaScriptBlocklist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "JavaScriptBlockedForUrls" -Type "MultiString" -Value $JavaScriptBlocklist
    }
}

# Function to configure Network settings
function Set-EdgeNetwork {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$DnsOverHttpsEnabled = $true,

        [Parameter(Mandatory=$false)]
        [string]$DnsOverHttpsTemplates = "",

        [Parameter(Mandatory=$false)]
        [bool]$NetworkPredictionEnabled = $true
    )

    Set-EdgePolicy -PolicyName "DnsOverHttpsMode" -Type "DWord" -Value ($DnsOverHttpsEnabled ? 1 : 0)
    if (-not [string]::IsNullOrEmpty($DnsOverHttpsTemplates)) {
        Set-EdgePolicy -PolicyName "DnsOverHttpsTemplates" -Type "String" -Value $DnsOverHttpsTemplates
    }
    Set-EdgePolicy -PolicyName "NetworkPredictionOptions" -Type "DWord" -Value ($NetworkPredictionEnabled ? 1 : 0)
}

# Function to configure Developer settings
function Set-EdgeDeveloper {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$DeveloperToolsEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$RemoteDebuggingEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$WebAssemblyModuleSharingEnabled = $true
    )

    Set-EdgePolicy -PolicyName "DeveloperToolsAvailability" -Type "DWord" -Value ($DeveloperToolsEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "RemoteDebuggingEnabled" -Type "DWord" -Value ($RemoteDebuggingEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "CrossOriginWebAssemblyModuleSharingEnabled" -Type "DWord" -Value ($WebAssemblyModuleSharingEnabled ? 1 : 0)
}

# Function to configure Update settings
function Set-EdgeUpdate {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$ComponentUpdatesEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$AutoUpdateEnabled = $true,

        [Parameter(Mandatory=$false)]
        [int]$UpdateIntervalHours = 24
    )

    Set-EdgePolicy -PolicyName "ComponentUpdatesEnabled" -Type "DWord" -Value ($ComponentUpdatesEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "AutoUpdateEnabled" -Type "DWord" -Value ($AutoUpdateEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "UpdateIntervalHours" -Type "DWord" -Value $UpdateIntervalHours
}

# Function to configure Accessibility settings
function Set-EdgeAccessibility {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$LiveCaptionsEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$ImmersiveReaderEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$MicrosoftEditorEnabled = $true
    )

    Set-EdgePolicy -PolicyName "LiveCaptionsAllowed" -Type "DWord" -Value ($LiveCaptionsEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "ImmersiveReaderGrammarToolsEnabled" -Type "DWord" -Value ($ImmersiveReaderEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "MicrosoftEditorProofingEnabled" -Type "DWord" -Value ($MicrosoftEditorEnabled ? 1 : 0)
}

# Function to configure Extensions settings
function Set-EdgeExtensions {
    param (
        [Parameter(Mandatory=$false)]
        [string[]]$InstallAllowlist = @(),

        [Parameter(Mandatory=$false)]
        [string[]]$InstallBlocklist = @(),

        [Parameter(Mandatory=$false)]
        [string[]]$InstallForcelist = @()
    )

    if ($InstallAllowlist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallAllowlist" -Type "MultiString" -Value $InstallAllowlist
    }

    if ($InstallBlocklist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallBlocklist" -Type "MultiString" -Value $InstallBlocklist
    }

    if ($InstallForcelist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallForcelist" -Type "MultiString" -Value $InstallForcelist
    }
}

# Function to configure Search settings
function Set-EdgeSearch {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$MicrosoftSearchEnabled = $true,

        [Parameter(Mandatory=$false)]
        [string]$SearchProviderName = "",

        [Parameter(Mandatory=$false)]
        [string]$SearchProviderURL = ""
    )

    Set-EdgePolicy -PolicyName "AddressBarMicrosoftSearchInBingProviderEnabled" -Type "DWord" -Value ($MicrosoftSearchEnabled ? 1 : 0)

    if (-not [string]::IsNullOrEmpty($SearchProviderName)) {
        Set-EdgePolicy -PolicyName "DefaultSearchProviderName" -Type "String" -Value $SearchProviderName
    }

    if (-not [string]::IsNullOrEmpty($SearchProviderURL)) {
        Set-EdgePolicy -PolicyName "DefaultSearchProviderSearchURL" -Type "String" -Value $SearchProviderURL
    }
}

# Function to configure New Tab Page settings
function Set-EdgeNewTabPage {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true,

        [Parameter(Mandatory=$false)]
        [string]$Location = "",

        [Parameter(Mandatory=$false)]
        [string[]]$QuickLinks = @()
    )

    Set-EdgePolicy -PolicyName "NewTabPageContentEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)

    if (-not [string]::IsNullOrEmpty($Location)) {
        Set-EdgePolicy -PolicyName "NewTabPageLocation" -Type "String" -Value $Location
    }

    if ($QuickLinks.Count -gt 0) {
        Set-EdgePolicy -PolicyName "NewTabPageManagedQuickLinks" -Type "MultiString" -Value $QuickLinks
    }
}

# Function to configure Application Guard settings
function Set-EdgeApplicationGuard {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$ContainerProxy = $false,

        [Parameter(Mandatory=$false)]
        [bool]$FavoritesSyncEnabled = $false,

        [Parameter(Mandatory=$false)]
        [bool]$PassiveModeEnabled = $false,

        [Parameter(Mandatory=$false)]
        [bool]$TrafficIdentificationEnabled = $false,

        [Parameter(Mandatory=$false)]
        [bool]$UploadBlockingEnabled = $false
    )

    # Application Guard Container Proxy
    Set-EdgePolicy -PolicyName "ApplicationGuardContainerProxy" -Type "DWord" -Value ($ContainerProxy ? 1 : 0)

    # Application Guard Favorites Sync
    Set-EdgePolicy -PolicyName "ApplicationGuardFavoritesSyncEnabled" -Type "DWord" -Value ($FavoritesSyncEnabled ? 1 : 0)

    # Application Guard Passive Mode
    Set-EdgePolicy -PolicyName "ApplicationGuardPassiveModeEnabled" -Type "DWord" -Value ($PassiveModeEnabled ? 1 : 0)

    # Application Guard Traffic Identification
    Set-EdgePolicy -PolicyName "ApplicationGuardTrafficIdentificationEnabled" -Type "DWord" -Value ($TrafficIdentificationEnabled ? 1 : 0)

    # Application Guard Upload Blocking
    Set-EdgePolicy -PolicyName "ApplicationGuardUploadBlockingEnabled" -Type "DWord" -Value ($UploadBlockingEnabled ? 1 : 0)
}

# Function to configure Cast settings
function Set-EdgeCast {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$EnableDialProtocol = $true,

        [Parameter(Mandatory=$false)]
        [bool]$EnableMediaRouter = $true
    )

    # Disable DIAL protocol for cast device discovery
    Set-EdgePolicy -PolicyName "EdgeDisableDialProtocolForCastDiscovery" -Type "DWord" -Value ($EnableDialProtocol ? 0 : 1)

    # Enable Media Router
    Set-EdgePolicy -PolicyName "EnableMediaRouter" -Type "DWord" -Value ($EnableMediaRouter ? 1 : 0)
}

# Function to configure Certificate Management settings
function Set-EdgeCertificateManagement {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true,

        [Parameter(Mandatory=$false)]
        [string[]]$CACertificates = @()
    )

    # Certificate Management Allowed
    Set-EdgePolicy -PolicyName "CACertificateManagementAllowed" -Type "DWord" -Value ($Enabled ? 1 : 0)

    # CA Certificates
    if ($CACertificates.Count -gt 0) {
        Set-EdgePolicy -PolicyName "CACertificates" -Type "MultiString" -Value $CACertificates
    }
}

# Function to configure Content Settings
function Set-EdgeContentSettings {
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Allow", "Block", "Ask")]
        [string]$JavaScriptSetting = "Allow",

        [Parameter(Mandatory=$false)]
        [string[]]$JavaScriptAllowedForUrls = @(),

        [Parameter(Mandatory=$false)]
        [string[]]$JavaScriptBlockedForUrls = @()
    )

    # Default JavaScript Setting
    switch ($JavaScriptSetting) {
        "Allow" { Set-EdgePolicy -PolicyName "DefaultJavaScriptSetting" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DefaultJavaScriptSetting" -Type "DWord" -Value 2 }
        "Ask" { Set-EdgePolicy -PolicyName "DefaultJavaScriptSetting" -Type "DWord" -Value 0 }
    }

    # JavaScript Allowed For URLs
    if ($JavaScriptAllowedForUrls.Count -gt 0) {
        Set-EdgePolicy -PolicyName "JavaScriptAllowedForUrls" -Type "MultiString" -Value $JavaScriptAllowedForUrls
    }

    # JavaScript Blocked For URLs
    if ($JavaScriptBlockedForUrls.Count -gt 0) {
        Set-EdgePolicy -PolicyName "JavaScriptBlockedForUrls" -Type "MultiString" -Value $JavaScriptBlockedForUrls
    }
}

# Function to configure HTTP Authentication settings
function Set-EdgeHttpAuth {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$NegotiateEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$BasicAuthOverHttp = $true,

        [Parameter(Mandatory=$false)]
        [string[]]$Allowlist = @(),

        [Parameter(Mandatory=$false)]
        [string[]]$DelegateAllowlist = @()
    )

    Set-EdgePolicy -PolicyName "AuthNegotiateEnabled" -Type "DWord" -Value ($NegotiateEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "BasicAuthOverHttpEnabled" -Type "DWord" -Value ($BasicAuthOverHttp ? 1 : 0)

    if ($Allowlist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "AuthServerAllowlist" -Type "MultiString" -Value $Allowlist
    }

    if ($DelegateAllowlist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "AuthNegotiateDelegateAllowlist" -Type "MultiString" -Value $DelegateAllowlist
    }
}

# Function to configure Printing settings
function Set-EdgePrinting {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$BackgroundGraphics = $true,

        [Parameter(Mandatory=$false)]
        [string]$DefaultPrinter = "",

        [Parameter(Mandatory=$false)]
        [ValidateSet("A4", "Letter", "Legal")]
        [string]$PaperSize = "A4"
    )

    Set-EdgePolicy -PolicyName "PrintingEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "PrintingBackgroundGraphicsDefault" -Type "DWord" -Value ($BackgroundGraphics ? 1 : 0)

    if (-not [string]::IsNullOrEmpty($DefaultPrinter)) {
        Set-EdgePolicy -PolicyName "DefaultPrinterSelection" -Type "String" -Value $DefaultPrinter
    }

    switch ($PaperSize) {
        "A4" { Set-EdgePolicy -PolicyName "PrintingPaperSizeDefault" -Type "String" -Value "A4" }
        "Letter" { Set-EdgePolicy -PolicyName "PrintingPaperSizeDefault" -Type "String" -Value "Letter" }
        "Legal" { Set-EdgePolicy -PolicyName "PrintingPaperSizeDefault" -Type "String" -Value "Legal" }
    }
}

# Function to configure WebRTC settings
function Set-EdgeWebRTC {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$LocalhostIpHandling = $true,

        [Parameter(Mandatory=$false)]
        [string]$IPHandlingUrl = ""
    )

    Set-EdgePolicy -PolicyName "WebRtcEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "WebRtcLocalhostIpHandling" -Type "DWord" -Value ($LocalhostIpHandling ? 1 : 0)

    if (-not [string]::IsNullOrEmpty($IPHandlingUrl)) {
        Set-EdgePolicy -PolicyName "WebRtcIPHandlingUrl" -Type "String" -Value $IPHandlingUrl
    }
}

# Function to configure Sleeping Tabs settings
function Set-EdgeSleepingTabs {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true,

        [Parameter(Mandatory=$false)]
        [int]$Timeout = 30,

        [Parameter(Mandatory=$false)]
        [string[]]$BlockedUrls = @()
    )

    Set-EdgePolicy -PolicyName "SleepingTabsEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "SleepingTabsTimeout" -Type "DWord" -Value $Timeout

    if ($BlockedUrls.Count -gt 0) {
        Set-EdgePolicy -PolicyName "SleepingTabsBlockedForUrls" -Type "MultiString" -Value $BlockedUrls
    }
}

# Function to configure PDF Reader settings
function Set-EdgePDFReader {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$AlwaysOpenExternally = $false,

        [Parameter(Mandatory=$false)]
        [string[]]$XFAAllowedHashes = @()
    )

    Set-EdgePolicy -PolicyName "PDFReaderEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "AlwaysOpenPdfExternally" -Type "DWord" -Value ($AlwaysOpenExternally ? 1 : 0)

    if ($XFAAllowedHashes.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ViewXFAPDFInIEModeAllowedFileHash" -Type "MultiString" -Value $XFAAllowedHashes
    }
}

# Function to configure Identity and Sign-in settings
function Set-EdgeIdentity {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$DefaultProfileEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$ImplicitSignInEnabled = $true,

        [Parameter(Mandatory=$false)]
        [string[]]$IntranetSites = @()
    )

    Set-EdgePolicy -PolicyName "EdgeDefaultProfileEnabled" -Type "DWord" -Value ($DefaultProfileEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "ImplicitSignInEnabled" -Type "DWord" -Value ($ImplicitSignInEnabled ? 1 : 0)

    if ($IntranetSites.Count -gt 0) {
        Set-EdgePolicy -PolicyName "SwitchIntranetSitesToWorkProfile" -Type "MultiString" -Value $IntranetSites
    }
}

# Function to configure Network settings
function Set-EdgeNetwork {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$DnsOverHttpsEnabled = $true,

        [Parameter(Mandatory=$false)]
        [string]$DnsOverHttpsTemplates = "",

        [Parameter(Mandatory=$false)]
        [bool]$NetworkPredictionEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$CompressionEnabled = $true
    )

    Set-EdgePolicy -PolicyName "DnsOverHttpsMode" -Type "DWord" -Value ($DnsOverHttpsEnabled ? 1 : 0)
    if (-not [string]::IsNullOrEmpty($DnsOverHttpsTemplates)) {
        Set-EdgePolicy -PolicyName "DnsOverHttpsTemplates" -Type "String" -Value $DnsOverHttpsTemplates
    }
    Set-EdgePolicy -PolicyName "NetworkPredictionOptions" -Type "DWord" -Value ($NetworkPredictionEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "CompressionDictionaryTransportEnabled" -Type "DWord" -Value ($CompressionEnabled ? 1 : 0)
}

# Function to configure Address Bar settings
function Set-EdgeAddressBar {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$EditingEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$MicrosoftSearchEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$TrendingSuggestEnabled = $true
    )

    Set-EdgePolicy -PolicyName "AddressBarEditingEnabled" -Type "DWord" -Value ($EditingEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "AddressBarMicrosoftSearchInBingProviderEnabled" -Type "DWord" -Value ($MicrosoftSearchEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "AddressBarTrendingSuggestEnabled" -Type "DWord" -Value ($TrendingSuggestEnabled ? 1 : 0)
}

# Function to configure Downloads settings
function Set-EdgeDownloads {
    param (
        [Parameter(Mandatory=$false)]
        [string]$DownloadDirectory = "",

        [Parameter(Mandatory=$false)]
        [ValidateSet("None", "Prompt", "Block")]
        [string]$Restrictions = "None",

        [Parameter(Mandatory=$false)]
        [bool]$ShowInsecureWarnings = $true,

        [Parameter(Mandatory=$false)]
        [bool]$AllowMixedContent = $false,

        [Parameter(Mandatory=$false)]
        [bool]$AllowLocalFiles = $false
    )

    # Download Directory
    if (-not [string]::IsNullOrEmpty($DownloadDirectory)) {
        Set-EdgePolicy -PolicyName "DownloadDirectory" -Type "String" -Value $DownloadDirectory
    }

    # Download Restrictions
    switch ($Restrictions) {
        "None" { Set-EdgePolicy -PolicyName "DownloadRestrictions" -Type "DWord" -Value 0 }
        "Prompt" { Set-EdgePolicy -PolicyName "DownloadRestrictions" -Type "DWord" -Value 1 }
        "Block" { Set-EdgePolicy -PolicyName "DownloadRestrictions" -Type "DWord" -Value 2 }
    }

    # Show Insecure Download Warnings
    Set-EdgePolicy -PolicyName "ShowDownloadsInsecureWarningsEnabled" -Type "DWord" -Value ($ShowInsecureWarnings ? 1 : 0)

    # Allow Mixed Content Downloads
    Set-EdgePolicy -PolicyName "AllowMixedContentDownloads" -Type "DWord" -Value ($AllowMixedContent ? 1 : 0)

    # Allow Local Files
    Set-EdgePolicy -PolicyName "AllowLocalFileDownloads" -Type "DWord" -Value ($AllowLocalFiles ? 1 : 0)
}

# Function to configure SmartScreen settings
function Set-EdgeSmartScreen {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$ForTrustedDownloads = $true,

        [Parameter(Mandatory=$false)]
        [string[]]$AllowListDomains = @()
    )

    Set-EdgePolicy -PolicyName "SmartScreenEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "SmartScreenForTrustedDownloadsEnabled" -Type "DWord" -Value ($ForTrustedDownloads ? 1 : 0)

    if ($AllowListDomains.Count -gt 0) {
        Set-EdgePolicy -PolicyName "SmartScreenAllowListDomains" -Type "MultiString" -Value $AllowListDomains
    }
}

# Function to configure Privacy settings
function Set-EdgePrivacy {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$ClearBrowsingDataOnExit = $true,

        [Parameter(Mandatory=$false)]
        [bool]$ClearCachedImagesAndFilesOnExit = $true,

        [Parameter(Mandatory=$false)]
        [bool]$BlockThirdPartyCookies = $true
    )

    Set-EdgePolicy -PolicyName "ClearBrowsingDataOnExit" -Type "DWord" -Value ($ClearBrowsingDataOnExit ? 1 : 0)
    Set-EdgePolicy -PolicyName "ClearCachedImagesAndFilesOnExit" -Type "DWord" -Value ($ClearCachedImagesAndFilesOnExit ? 1 : 0)
    Set-EdgePolicy -PolicyName "BlockThirdPartyCookies" -Type "DWord" -Value ($BlockThirdPartyCookies ? 1 : 0)
}

# Function to configure Performance settings
function Set-EdgePerformance {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$EfficiencyModeEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$StartupBoostEnabled = $true,

        [Parameter(Mandatory=$false)]
        [ValidateSet("Low", "Medium", "High")]
        [string]$EfficiencyMode = "Medium"
    )

    Set-EdgePolicy -PolicyName "EfficiencyModeEnabled" -Type "DWord" -Value ($EfficiencyModeEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "StartupBoostEnabled" -Type "DWord" -Value ($StartupBoostEnabled ? 1 : 0)

    switch ($EfficiencyMode) {
        "Low" { Set-EdgePolicy -PolicyName "EfficiencyMode" -Type "DWord" -Value 1 }
        "Medium" { Set-EdgePolicy -PolicyName "EfficiencyMode" -Type "DWord" -Value 2 }
        "High" { Set-EdgePolicy -PolicyName "EfficiencyMode" -Type "DWord" -Value 3 }
    }
}

# Function to configure UI settings
function Set-EdgeUI {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$ShowHomeButton = $true,

        [Parameter(Mandatory=$false)]
        [bool]$FavoritesBarEnabled = $false,

        [Parameter(Mandatory=$false)]
        [bool]$MouseGestureEnabled = $true
    )

    Set-EdgePolicy -PolicyName "ShowHomeButton" -Type "DWord" -Value ($ShowHomeButton ? 1 : 0)
    Set-EdgePolicy -PolicyName "FavoritesBarEnabled" -Type "DWord" -Value ($FavoritesBarEnabled ? 1 : 0)
    Set-EdgePolicy -PolicyName "MouseGestureEnabled" -Type "DWord" -Value ($MouseGestureEnabled ? 1 : 0)
}

# Function to configure Startup settings
function Set-EdgeStartup {
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Default", "LastSession", "SpecificURLs")]
        [string]$RestoreOnStartup = "Default",

        [Parameter(Mandatory=$false)]
        [string[]]$StartupURLs = @()
    )

    switch ($RestoreOnStartup) {
        "Default" { Set-EdgePolicy -PolicyName "RestoreOnStartup" -Type "DWord" -Value 0 }
        "LastSession" { Set-EdgePolicy -PolicyName "RestoreOnStartup" -Type "DWord" -Value 1 }
        "SpecificURLs" {
            Set-EdgePolicy -PolicyName "RestoreOnStartup" -Type "DWord" -Value 4
            if ($StartupURLs.Count -gt 0) {
                Set-EdgePolicy -PolicyName "RestoreOnStartupURLs" -Type "MultiString" -Value $StartupURLs
            }
        }
    }
}

# Function to configure Proxy settings
function Set-EdgeProxy {
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Direct", "AutoDetect", "PacScript", "FixedServers")]
        [string]$Mode = "AutoDetect",

        [Parameter(Mandatory=$false)]
        [string]$Server = "",

        [Parameter(Mandatory=$false)]
        [string]$PacUrl = "",

        [Parameter(Mandatory=$false)]
        [string[]]$BypassList = @()
    )

    switch ($Mode) {
        "Direct" { Set-EdgePolicy -PolicyName "ProxyMode" -Type "String" -Value "direct" }
        "AutoDetect" { Set-EdgePolicy -PolicyName "ProxyMode" -Type "String" -Value "auto_detect" }
        "PacScript" {
            Set-EdgePolicy -PolicyName "ProxyMode" -Type "String" -Value "pac_script"
            if (-not [string]::IsNullOrEmpty($PacUrl)) {
                Set-EdgePolicy -PolicyName "ProxyPacUrl" -Type "String" -Value $PacUrl
            }
        }
        "FixedServers" {
            Set-EdgePolicy -PolicyName "ProxyMode" -Type "String" -Value "fixed_servers"
            if (-not [string]::IsNullOrEmpty($Server)) {
                Set-EdgePolicy -PolicyName "ProxyServer" -Type "String" -Value $Server
            }
        }
    }

    if ($BypassList.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ProxyBypassList" -Type "MultiString" -Value $BypassList
    }
}

# Function to configure Extensions settings
function Set-EdgeExtensions {
    param (
        [Parameter(Mandatory=$false)]
        [string[]]$InstallAllowlist = @(),

        [Parameter(Mandatory=$false)]
        [string[]]$InstallBlocklist = @(),

        [Parameter(Mandatory=$false)]
        [string[]]$InstallForcelist = @()
    )

    if ($InstallAllowlist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallAllowlist" -Type "MultiString" -Value $InstallAllowlist
    }

    if ($InstallBlocklist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallBlocklist" -Type "MultiString" -Value $InstallBlocklist
    }

    if ($InstallForcelist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallForcelist" -Type "MultiString" -Value $InstallForcelist
    }
}

# Function to configure Search settings
function Set-EdgeSearch {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$MicrosoftSearchEnabled = $true,

        [Parameter(Mandatory=$false)]
        [string]$SearchProviderName = "",

        [Parameter(Mandatory=$false)]
        [string]$SearchProviderURL = ""
    )

    Set-EdgePolicy -PolicyName "AddressBarMicrosoftSearchInBingProviderEnabled" -Type "DWord" -Value ($MicrosoftSearchEnabled ? 1 : 0)

    if (-not [string]::IsNullOrEmpty($SearchProviderName)) {
        Set-EdgePolicy -PolicyName "DefaultSearchProviderName" -Type "String" -Value $SearchProviderName
    }

    if (-not [string]::IsNullOrEmpty($SearchProviderURL)) {
        Set-EdgePolicy -PolicyName "DefaultSearchProviderSearchURL" -Type "String" -Value $SearchProviderURL
    }
}

# Function to configure New Tab Page settings
function Set-EdgeNewTabPage {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true,

        [Parameter(Mandatory=$false)]
        [string]$Location = "",

        [Parameter(Mandatory=$false)]
        [string[]]$QuickLinks = @()
    )

    Set-EdgePolicy -PolicyName "NewTabPageContentEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)

    if (-not [string]::IsNullOrEmpty($Location)) {
        Set-EdgePolicy -PolicyName "NewTabPageLocation" -Type "String" -Value $Location
    }

    if ($QuickLinks.Count -gt 0) {
        Set-EdgePolicy -PolicyName "NewTabPageManagedQuickLinks" -Type "MultiString" -Value $QuickLinks
    }
}

# Function to configure Default Search Provider settings
function Set-EdgeDefaultSearchProvider {
    param (
        [Parameter(Mandatory=$false)]
        [string]$Name = "Microsoft Bing",

        [Parameter(Mandatory=$false)]
        [string]$SearchURL = "https://www.bing.com/search?q={searchTerms}",

        [Parameter(Mandatory=$false)]
        [string]$Keyword = "bing",

        [Parameter(Mandatory=$false)]
        [bool]$IsDefault = $true,

        [Parameter(Mandatory=$false)]
        [string]$SearchURLPostParams = "",

        [Parameter(Mandatory=$false)]
        [string]$SearchURLGetParams = "",

        [Parameter(Mandatory=$false)]
        [string]$SuggestURL = "https://www.bing.com/osjson.aspx?query={searchTerms}",

        [Parameter(Mandatory=$false)]
        [string]$SuggestURLPostParams = "",

        [Parameter(Mandatory=$false)]
        [string]$SuggestURLGetParams = "",

        [Parameter(Mandatory=$false)]
        [string]$IconURL = "https://www.bing.com/favicon.ico",

        [Parameter(Mandatory=$false)]
        [string]$Encoding = "UTF-8"
    )

    # Search Provider Name
    Set-EdgePolicy -PolicyName "DefaultSearchProviderName" -Type "String" -Value $Name

    # Search URL
    Set-EdgePolicy -PolicyName "DefaultSearchProviderSearchURL" -Type "String" -Value $SearchURL

    # Keyword
    Set-EdgePolicy -PolicyName "DefaultSearchProviderKeyword" -Type "String" -Value $Keyword

    # Is Default
    Set-EdgePolicy -PolicyName "DefaultSearchProviderIsDefault" -Type "DWord" -Value ($IsDefault ? 1 : 0)

    # Search URL Post Params
    if (-not [string]::IsNullOrEmpty($SearchURLPostParams)) {
        Set-EdgePolicy -PolicyName "DefaultSearchProviderSearchURLPostParams" -Type "String" -Value $SearchURLPostParams
    }

    # Search URL Get Params
    if (-not [string]::IsNullOrEmpty($SearchURLGetParams)) {
        Set-EdgePolicy -PolicyName "DefaultSearchProviderSearchURLGetParams" -Type "String" -Value $SearchURLGetParams
    }

    # Suggest URL
    if (-not [string]::IsNullOrEmpty($SuggestURL)) {
        Set-EdgePolicy -PolicyName "DefaultSearchProviderSuggestURL" -Type "String" -Value $SuggestURL
    }

    # Suggest URL Post Params
    if (-not [string]::IsNullOrEmpty($SuggestURLPostParams)) {
        Set-EdgePolicy -PolicyName "DefaultSearchProviderSuggestURLPostParams" -Type "String" -Value $SuggestURLPostParams
    }

    # Suggest URL Get Params
    if (-not [string]::IsNullOrEmpty($SuggestURLGetParams)) {
        Set-EdgePolicy -PolicyName "DefaultSearchProviderSuggestURLGetParams" -Type "String" -Value $SuggestURLGetParams
    }

    # Icon URL
    if (-not [string]::IsNullOrEmpty($IconURL)) {
        Set-EdgePolicy -PolicyName "DefaultSearchProviderIconURL" -Type "String" -Value $IconURL
    }

    # Encoding
    if (-not [string]::IsNullOrEmpty($Encoding)) {
        Set-EdgePolicy -PolicyName "DefaultSearchProviderEncoding" -Type "String" -Value $Encoding
    }
}

# Function to set multiple policies from a hashtable
function Set-EdgePoliciesFromRegistry {
    param (
        [Parameter(Mandatory=$true)]
        [hashtable]$PolicySettings
    )

    foreach ($PolicyName in $PolicySettings.Keys) {
        $Value = $PolicySettings[$PolicyName]

        # Determine the type of the value and set the policy accordingly
        if ($Value -is [int]) {
            Set-EdgePolicy -PolicyName $PolicyName -Type "DWord" -Value $Value
        } elseif ($Value -is [string]) {
            Set-EdgePolicy -PolicyName $PolicyName -Type "String" -Value $Value
        } elseif ($Value -is [string[]]) {
            Set-EdgePolicy -PolicyName $PolicyName -Type "MultiString" -Value $Value
        } elseif ($Value -is [byte[]]) {
            Set-EdgePolicy -PolicyName $PolicyName -Type "Binary" -Value $Value
        } else {
            Write-Warning "Unsupported type for policy '$PolicyName'. Skipping."
        }
    }
}

# Function to configure Edge Website Typo Protection settings
function Set-EdgeWebsiteTypoProtection {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true,

        [Parameter(Mandatory=$false)]
        [string[]]$ProtectedDomains = @(),

        [Parameter(Mandatory=$false)]
        [bool]$ShowWarnings = $true,

        [Parameter(Mandatory=$false)]
        [bool]$BlockSuspiciousSites = $true
    )

    # Website Typo Protection Enabled
    Set-EdgePolicy -PolicyName "EdgeWebsiteTypoProtectionEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)

    # Protected Domains
    if ($ProtectedDomains.Count -gt 0) {
        Set-EdgePolicy -PolicyName "EdgeWebsiteTypoProtectionProtectedDomains" -Type "MultiString" -Value $ProtectedDomains
    }

    # Show Warnings
    Set-EdgePolicy -PolicyName "EdgeWebsiteTypoProtectionShowWarnings" -Type "DWord" -Value ($ShowWarnings ? 1 : 0)

    # Block Suspicious Sites
    Set-EdgePolicy -PolicyName "EdgeWebsiteTypoProtectionBlockSuspiciousSites" -Type "DWord" -Value ($BlockSuspiciousSites ? 1 : 0)
}

# Function to configure Extensions settings
function Set-EdgeExtensions {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$BlockExternal = $false,

        [Parameter(Mandatory=$false)]
        [bool]$AllowFromOtherStores = $false,

        [Parameter(Mandatory=$false)]
        [string[]]$AllowedTypes = @(),

        [Parameter(Mandatory=$false)]
        [bool]$DeveloperMode = $false,

        [Parameter(Mandatory=$false)]
        [string[]]$InstallAllowlist = @(),

        [Parameter(Mandatory=$false)]
        [string[]]$InstallBlocklist = @(),

        [Parameter(Mandatory=$false)]
        [string[]]$InstallForcelist = @(),

        [Parameter(Mandatory=$false)]
        [string[]]$InstallSources = @(),

        [Parameter(Mandatory=$false)]
        [string[]]$InstallTypeBlocklist = @(),

        [Parameter(Mandatory=$false)]
        [bool]$ManifestV2Availability = $false
    )

    # Block External Extensions
    Set-EdgePolicy -PolicyName "BlockExternalExtensions" -Type "DWord" -Value ($BlockExternal ? 1 : 0)

    # Allow Extensions from Other Stores
    Set-EdgePolicy -PolicyName "ControlDefaultStateOfAllowExtensionFromOtherStoresSettingEnabled" -Type "DWord" -Value ($AllowFromOtherStores ? 1 : 0)

    # Extension Allowed Types
    if ($AllowedTypes.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionAllowedTypes" -Type "MultiString" -Value $AllowedTypes
    }

    # Extension Developer Mode
    Set-EdgePolicy -PolicyName "ExtensionDeveloperModeSettings" -Type "DWord" -Value ($DeveloperMode ? 1 : 0)

    # Extension Install Allowlist
    if ($InstallAllowlist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallAllowlist" -Type "MultiString" -Value $InstallAllowlist
    }

    # Extension Install Blocklist
    if ($InstallBlocklist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallBlocklist" -Type "MultiString" -Value $InstallBlocklist
    }

    # Extension Install Forcelist
    if ($InstallForcelist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallForcelist" -Type "MultiString" -Value $InstallForcelist
    }

    # Extension Install Sources
    if ($InstallSources.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallSources" -Type "MultiString" -Value $InstallSources
    }

    # Extension Install Type Blocklist
    if ($InstallTypeBlocklist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ExtensionInstallTypeBlocklist" -Type "MultiString" -Value $InstallTypeBlocklist
    }

    # Extension Manifest V2 Availability
    Set-EdgePolicy -PolicyName "ExtensionManifestV2Availability" -Type "DWord" -Value ($ManifestV2Availability ? 1 : 0)
}

# Function to configure HTTP Authentication settings
function Set-EdgeHttpAuthentication {
    param (
        [Parameter(Mandatory=$false)]
        [string[]]$AllAuthSchemesAllowedForOrigins = @(),

        [Parameter(Mandatory=$false)]
        [bool]$AllowCrossOriginAuth = $false,

        [Parameter(Mandatory=$false)]
        [string[]]$AuthNegotiateDelegateAllowlist = @(),

        [Parameter(Mandatory=$false)]
        [string]$AuthSchemes = "basic,digest,ntlm,negotiate",

        [Parameter(Mandatory=$false)]
        [string[]]$AuthServerAllowlist = @(),

        [Parameter(Mandatory=$false)]
        [bool]$BasicAuthOverHttp = $false,

        [Parameter(Mandatory=$false)]
        [bool]$DisableAuthNegotiateCnameLookup = $false,

        [Parameter(Mandatory=$false)]
        [bool]$EnableAuthNegotiatePort = $false,

        [Parameter(Mandatory=$false)]
        [bool]$NtlmV2Enabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$WindowsHelloForHttpAuth = $false
    )

    # All HTTP Auth Schemes Allowed For Origins
    if ($AllAuthSchemesAllowedForOrigins.Count -gt 0) {
        Set-EdgePolicy -PolicyName "AllHttpAuthSchemesAllowedForOrigins" -Type "MultiString" -Value $AllAuthSchemesAllowedForOrigins
    }

    # Allow Cross Origin Auth Prompt
    Set-EdgePolicy -PolicyName "AllowCrossOriginAuthPrompt" -Type "DWord" -Value ($AllowCrossOriginAuth ? 1 : 0)

    # Auth Negotiate Delegate Allowlist
    if ($AuthNegotiateDelegateAllowlist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "AuthNegotiateDelegateAllowlist" -Type "MultiString" -Value $AuthNegotiateDelegateAllowlist
    }

    # Auth Schemes
    Set-EdgePolicy -PolicyName "AuthSchemes" -Type "String" -Value $AuthSchemes

    # Auth Server Allowlist
    if ($AuthServerAllowlist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "AuthServerAllowlist" -Type "MultiString" -Value $AuthServerAllowlist
    }

    # Basic Auth Over HTTP
    Set-EdgePolicy -PolicyName "BasicAuthOverHttpEnabled" -Type "DWord" -Value ($BasicAuthOverHttp ? 1 : 0)

    # Disable Auth Negotiate Cname Lookup
    Set-EdgePolicy -PolicyName "DisableAuthNegotiateCnameLookup" -Type "DWord" -Value ($DisableAuthNegotiateCnameLookup ? 1 : 0)

    # Enable Auth Negotiate Port
    Set-EdgePolicy -PolicyName "EnableAuthNegotiatePort" -Type "DWord" -Value ($EnableAuthNegotiatePort ? 1 : 0)

    # NTLMv2 Enabled
    Set-EdgePolicy -PolicyName "NtlmV2Enabled" -Type "DWord" -Value ($NtlmV2Enabled ? 1 : 0)

    # Windows Hello For HTTP Auth
    Set-EdgePolicy -PolicyName "WindowsHelloForHTTPAuthEnabled" -Type "DWord" -Value ($WindowsHelloForHttpAuth ? 1 : 0)
}

# Function to configure Identity & Sign-in settings
function Set-EdgeIdentityAndSignIn {
    param (
        [Parameter(Mandatory=$false)]
        [string[]]$AutomaticProfileSwitchingSiteList = @(),

        [Parameter(Mandatory=$false)]
        [bool]$DefaultProfileEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$GuidedSwitchEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$ImplicitSignInEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$LinkedAccountEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$OneAuthAuthenticationEnforced = $true,

        [Parameter(Mandatory=$false)]
        [bool]$OnlyOnPremisesImplicitSignIn = $false,

        [Parameter(Mandatory=$false)]
        [bool]$ProactiveAuthWorkflowEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$SeamlessWebToBrowserSignInEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$WAMAuthBelowWin10RS3Enabled = $false,

        [Parameter(Mandatory=$false)]
        [bool]$WebToBrowserSignInEnabled = $true
    )

    # Automatic Profile Switching Site List
    if ($AutomaticProfileSwitchingSiteList.Count -gt 0) {
        Set-EdgePolicy -PolicyName "AutomaticProfileSwitchingSiteList" -Type "MultiString" -Value $AutomaticProfileSwitchingSiteList
    }

    # Default Profile Enabled
    Set-EdgePolicy -PolicyName "EdgeDefaultProfileEnabled" -Type "DWord" -Value ($DefaultProfileEnabled ? 1 : 0)

    # Guided Switch Enabled
    Set-EdgePolicy -PolicyName "GuidedSwitchEnabled" -Type "DWord" -Value ($GuidedSwitchEnabled ? 1 : 0)

    # Implicit Sign-in Enabled
    Set-EdgePolicy -PolicyName "ImplicitSignInEnabled" -Type "DWord" -Value ($ImplicitSignInEnabled ? 1 : 0)

    # Linked Account Enabled
    Set-EdgePolicy -PolicyName "LinkedAccountEnabled" -Type "DWord" -Value ($LinkedAccountEnabled ? 1 : 0)

    # OneAuth Authentication Enforced
    Set-EdgePolicy -PolicyName "OneAuthAuthenticationEnforced" -Type "DWord" -Value ($OneAuthAuthenticationEnforced ? 1 : 0)

    # Only On-Premises Implicit Sign-in
    Set-EdgePolicy -PolicyName "OnlyOnPremisesImplicitSignInEnabled" -Type "DWord" -Value ($OnlyOnPremisesImplicitSignIn ? 1 : 0)

    # Proactive Auth Workflow Enabled
    Set-EdgePolicy -PolicyName "ProactiveAuthWorkflowEnabled" -Type "DWord" -Value ($ProactiveAuthWorkflowEnabled ? 1 : 0)

    # Seamless Web To Browser Sign-in Enabled
    Set-EdgePolicy -PolicyName "SeamlessWebToBrowserSignInEnabled" -Type "DWord" -Value ($SeamlessWebToBrowserSignInEnabled ? 1 : 0)

    # WAM Auth Below Win10 RS3 Enabled
    Set-EdgePolicy -PolicyName "WAMAuthBelowWin10RS3Enabled" -Type "DWord" -Value ($WAMAuthBelowWin10RS3Enabled ? 1 : 0)

    # Web To Browser Sign-in Enabled
    Set-EdgePolicy -PolicyName "WebToBrowserSignInEnabled" -Type "DWord" -Value ($WebToBrowserSignInEnabled ? 1 : 0)
}

# Function to configure Network settings
function Set-EdgeNetwork {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$AccessControlAllowMethodsConformant = $true,

        [Parameter(Mandatory=$false)]
        [bool]$BlockTruncatedCookies = $true,

        [Parameter(Mandatory=$false)]
        [bool]$CompressionDictionaryTransportEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$DataURLWhitespacePreservationEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$IPv6ReachabilityOverrideEnabled = $false,

        [Parameter(Mandatory=$false)]
        [bool]$ZstdContentEncodingEnabled = $true
    )

    # Access Control Allow Methods Conformant
    Set-EdgePolicy -PolicyName "AccessControlAllowMethodsInCORSPreflightSpecConformant" -Type "DWord" -Value ($AccessControlAllowMethodsConformant ? 1 : 0)

    # Block Truncated Cookies
    Set-EdgePolicy -PolicyName "BlockTruncatedCookies" -Type "DWord" -Value ($BlockTruncatedCookies ? 1 : 0)

    # Compression Dictionary Transport Enabled
    Set-EdgePolicy -PolicyName "CompressionDictionaryTransportEnabled" -Type "DWord" -Value ($CompressionDictionaryTransportEnabled ? 1 : 0)

    # Data URL Whitespace Preservation
    Set-EdgePolicy -PolicyName "DataURLWhitespacePreservationEnabled" -Type "DWord" -Value ($DataURLWhitespacePreservationEnabled ? 1 : 0)

    # IPv6 Reachability Override
    Set-EdgePolicy -PolicyName "IPv6ReachabilityOverrideEnabled" -Type "DWord" -Value ($IPv6ReachabilityOverrideEnabled ? 1 : 0)

    # Zstd Content Encoding
    Set-EdgePolicy -PolicyName "ZstdContentEncodingEnabled" -Type "DWord" -Value ($ZstdContentEncodingEnabled ? 1 : 0)
}

# Function to configure PDF Reader settings
function Set-EdgePDFReader {
    param (
        [Parameter(Mandatory=$false)]
        [string[]]$ViewXFAAllowedFileHash = @(),

        [Parameter(Mandatory=$false)]
        [string[]]$ViewXFAAllowedOrigins = @()
    )

    # View XFA PDF in IE Mode Allowed File Hash
    if ($ViewXFAAllowedFileHash.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ViewXFAPDFInIEModeAllowedFileHash" -Type "MultiString" -Value $ViewXFAAllowedFileHash
    }

    # View XFA PDF in IE Mode Allowed Origins
    if ($ViewXFAAllowedOrigins.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ViewXFAPDFInIEModeAllowedOrigins" -Type "MultiString" -Value $ViewXFAAllowedOrigins
    }
}

# Function to configure Password Manager settings
function Set-EdgePasswordManager {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$DeletingUndecryptablePasswordsEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$PasswordDeleteOnBrowserCloseEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$PasswordExportEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$PasswordGeneratorEnabled = $true,

        [Parameter(Mandatory=$false)]
        [string[]]$PasswordManagerBlocklist = @(),

        [Parameter(Mandatory=$false)]
        [bool]$PasswordManagerEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$PasswordManagerRestrictLengthEnabled = $false,

        [Parameter(Mandatory=$false)]
        [bool]$PasswordMonitorAllowed = $true,

        [Parameter(Mandatory=$false)]
        [bool]$PasswordProtectionChangePasswordEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$PasswordProtectionEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$PasswordProtectionLeakDetectionEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$PasswordProtectionLeakDetectionURLCheckEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$PasswordProtectionLeakDetectionURLCheckEnabledForAllURLs = $false,

        [Parameter(Mandatory=$false)]
        [bool]$PasswordProtectionRecoveryEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$PasswordProtectionWarningEnabled = $true
    )

    # Deleting Undecryptable Passwords
    Set-EdgePolicy -PolicyName "DeletingUndecryptablePasswordsEnabled" -Type "DWord" -Value ($DeletingUndecryptablePasswordsEnabled ? 1 : 0)

    # Password Delete On Browser Close
    Set-EdgePolicy -PolicyName "PasswordDeleteOnBrowserCloseEnabled" -Type "DWord" -Value ($PasswordDeleteOnBrowserCloseEnabled ? 1 : 0)

    # Password Export
    Set-EdgePolicy -PolicyName "PasswordExportEnabled" -Type "DWord" -Value ($PasswordExportEnabled ? 1 : 0)

    # Password Generator
    Set-EdgePolicy -PolicyName "PasswordGeneratorEnabled" -Type "DWord" -Value ($PasswordGeneratorEnabled ? 1 : 0)

    # Password Manager Blocklist
    if ($PasswordManagerBlocklist.Count -gt 0) {
        Set-EdgePolicy -PolicyName "PasswordManagerBlocklist" -Type "MultiString" -Value $PasswordManagerBlocklist
    }

    # Password Manager Enabled
    Set-EdgePolicy -PolicyName "PasswordManagerEnabled" -Type "DWord" -Value ($PasswordManagerEnabled ? 1 : 0)

    # Password Manager Restrict Length
    Set-EdgePolicy -PolicyName "PasswordManagerRestrictLengthEnabled" -Type "DWord" -Value ($PasswordManagerRestrictLengthEnabled ? 1 : 0)

    # Password Monitor
    Set-EdgePolicy -PolicyName "PasswordMonitorAllowed" -Type "DWord" -Value ($PasswordMonitorAllowed ? 1 : 0)

    # Password Protection Change Password
    Set-EdgePolicy -PolicyName "PasswordProtectionChangePasswordEnabled" -Type "DWord" -Value ($PasswordProtectionChangePasswordEnabled ? 1 : 0)

    # Password Protection
    Set-EdgePolicy -PolicyName "PasswordProtectionEnabled" -Type "DWord" -Value ($PasswordProtectionEnabled ? 1 : 0)

    # Password Protection Leak Detection
    Set-EdgePolicy -PolicyName "PasswordProtectionLeakDetectionEnabled" -Type "DWord" -Value ($PasswordProtectionLeakDetectionEnabled ? 1 : 0)

    # Password Protection Leak Detection URL Check
    Set-EdgePolicy -PolicyName "PasswordProtectionLeakDetectionURLCheckEnabled" -Type "DWord" -Value ($PasswordProtectionLeakDetectionURLCheckEnabled ? 1 : 0)

    # Password Protection Leak Detection URL Check For All URLs
    Set-EdgePolicy -PolicyName "PasswordProtectionLeakDetectionURLCheckEnabledForAllURLs" -Type "DWord" -Value ($PasswordProtectionLeakDetectionURLCheckEnabledForAllURLs ? 1 : 0)

    # Password Protection Recovery
    Set-EdgePolicy -PolicyName "PasswordProtectionRecoveryEnabled" -Type "DWord" -Value ($PasswordProtectionRecoveryEnabled ? 1 : 0)

    # Password Protection Warning
    Set-EdgePolicy -PolicyName "PasswordProtectionWarningEnabled" -Type "DWord" -Value ($PasswordProtectionWarningEnabled ? 1 : 0)
}

# Function to configure Performance settings
function Set-EdgePerformance {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$EfficiencyModeEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$StartupBoostEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$SleepingTabsEnabled = $true,

        [Parameter(Mandatory=$false)]
        [int]$SleepingTabsDelaySeconds = 300,

        [Parameter(Mandatory=$false)]
        [bool]$SleepingTabsAutoDiscardEnabled = $true,

        [Parameter(Mandatory=$false)]
        [int]$SleepingTabsAutoDiscardDelaySeconds = 1800
    )

    # Efficiency Mode
    Set-EdgePolicy -PolicyName "EfficiencyModeEnabled" -Type "DWord" -Value ($EfficiencyModeEnabled ? 1 : 0)

    # Startup Boost
    Set-EdgePolicy -PolicyName "StartupBoostEnabled" -Type "DWord" -Value ($StartupBoostEnabled ? 1 : 0)

    # Sleeping Tabs
    Set-EdgePolicy -PolicyName "SleepingTabsEnabled" -Type "DWord" -Value ($SleepingTabsEnabled ? 1 : 0)

    # Sleeping Tabs Delay
    Set-EdgePolicy -PolicyName "SleepingTabsDelaySeconds" -Type "DWord" -Value $SleepingTabsDelaySeconds

    # Sleeping Tabs Auto Discard
    Set-EdgePolicy -PolicyName "SleepingTabsAutoDiscardEnabled" -Type "DWord" -Value ($SleepingTabsAutoDiscardEnabled ? 1 : 0)

    # Sleeping Tabs Auto Discard Delay
    Set-EdgePolicy -PolicyName "SleepingTabsAutoDiscardDelaySeconds" -Type "DWord" -Value $SleepingTabsAutoDiscardDelaySeconds
}

# Function to configure Screen Capture settings
function Set-EdgeScreenCapture {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$Enabled = $true,

        [Parameter(Mandatory=$false)]
        [string[]]$AllowedOrigins = @(),

        [Parameter(Mandatory=$false)]
        [string[]]$BlockedOrigins = @()
    )

    # Screen Capture Enabled
    Set-EdgePolicy -PolicyName "ScreenCaptureEnabled" -Type "DWord" -Value ($Enabled ? 1 : 0)

    # Screen Capture Allowed Origins
    if ($AllowedOrigins.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ScreenCaptureAllowedOrigins" -Type "MultiString" -Value $AllowedOrigins
    }

    # Screen Capture Blocked Origins
    if ($BlockedOrigins.Count -gt 0) {
        Set-EdgePolicy -PolicyName "ScreenCaptureBlockedOrigins" -Type "MultiString" -Value $BlockedOrigins
    }
}

# Function to configure Startup settings
function Set-EdgeStartup {
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Default", "LastSession", "SpecificURLs")]
        [string]$RestoreOnStartup = "Default",

        [Parameter(Mandatory=$false)]
        [string[]]$StartupURLs = @(),

        [Parameter(Mandatory=$false)]
        [bool]$ShowHomeButton = $true,

        [Parameter(Mandatory=$false)]
        [string]$HomepageLocation = "",

        [Parameter(Mandatory=$false)]
        [bool]$HomepageIsNewTabPage = $true,

        [Parameter(Mandatory=$false)]
        [bool]$ShowFavoritesBar = $false,

        [Parameter(Mandatory=$false)]
        [bool]$MouseGestureEnabled = $true,

        [Parameter(Mandatory=$false)]
        [bool]$VerticalTabsAllowed = $true
    )

    # Restore On Startup
    switch ($RestoreOnStartup) {
        "Default" { Set-EdgePolicy -PolicyName "RestoreOnStartup" -Type "DWord" -Value 4 }
        "LastSession" { Set-EdgePolicy -PolicyName "RestoreOnStartup" -Type "DWord" -Value 1 }
        "SpecificURLs" { Set-EdgePolicy -PolicyName "RestoreOnStartup" -Type "DWord" -Value 2 }
    }

    # Startup URLs
    if ($StartupURLs.Count -gt 0) {
        Set-EdgePolicy -PolicyName "URLsToRestoreOnStartup" -Type "MultiString" -Value $StartupURLs
    }

    # Home Button
    Set-EdgePolicy -PolicyName "ShowHomeButton" -Type "DWord" -Value ($ShowHomeButton ? 1 : 0)

    # Homepage Location
    if (-not [string]::IsNullOrEmpty($HomepageLocation)) {
        Set-EdgePolicy -PolicyName "HomepageLocation" -Type "String" -Value $HomepageLocation
    }

    # Homepage Is New Tab Page
    Set-EdgePolicy -PolicyName "HomepageIsNewTabPage" -Type "DWord" -Value ($HomepageIsNewTabPage ? 1 : 0)

    # Favorites Bar
    Set-EdgePolicy -PolicyName "FavoritesBarEnabled" -Type "DWord" -Value ($ShowFavoritesBar ? 1 : 0)

    # Mouse Gesture
    Set-EdgePolicy -PolicyName "MouseGestureEnabled" -Type "DWord" -Value ($MouseGestureEnabled ? 1 : 0)

    # Vertical Tabs
    Set-EdgePolicy -PolicyName "VerticalTabsAllowed" -Type "DWord" -Value ($VerticalTabsAllowed ? 1 : 0)
}

# Example Usage
# $EdgePolicySettings = @{
#     "HomepageLocation" = "https://www.microsoft.com"
#     "RestoreOnStartup" = 4
#     "StartupURLs"      = @("https://www.microsoft.com","https://www.bing.com")
# }
# Set-EdgePoliciesFromRegistry -PolicySettings $EdgePolicySettings

# Example usage:
# Configure Application Guard:
# Set-EdgeApplicationGuard -Enabled $true -ContainerProxy $true -FavoritesSync $true -BypassListDomains @("example.com")

# Configure Certificate Management:
# Set-EdgeCertificateManagement -Enabled $true -Certificates @("cert1.cer", "cert2.cer") -DistrustedCertificates @("blocked.cer")

# Configure HTTP Authentication:
# Set-EdgeHttpAuth -NegotiateEnabled $true -BasicAuthOverHttp $true -Allowlist @("example.com") -DelegateAllowlist @("delegate.com")

# Configure Printing:
# Set-EdgePrinting -Enabled $true -BackgroundGraphics $true -DefaultPrinter "Microsoft Print to PDF" -PaperSize "A4"

# Configure WebRTC:
# Set-EdgeWebRTC -Enabled $true -LocalhostIpHandling $true -IPHandlingUrl "https://example.com"

# Configure Sleeping Tabs:
# Set-EdgeSleepingTabs -Enabled $true -Timeout 30 -BlockedUrls @("example.com")

# Configure PDF Reader:
# Set-EdgePDFReader -Enabled $true -AlwaysOpenExternally $false -XFAAllowedHashes @("hash1", "hash2")

# Configure Identity:
# Set-EdgeIdentity -DefaultProfileEnabled $true -ImplicitSignInEnabled $true -IntranetSites @("intranet.example.com")

# Configure Network:
# Set-EdgeNetwork -DnsOverHttpsEnabled $true -DnsOverHttpsTemplates "https://dns.google/dns-query" -NetworkPredictionEnabled $true -CompressionEnabled $true

# Configure Address Bar:
# Set-EdgeAddressBar -EditingEnabled $true -MicrosoftSearchEnabled $true -TrendingSuggestEnabled $true

# Configure Downloads:
# Set-EdgeDownloads -Directory "C:\Downloads" -Restrictions "Prompt" -AllowedFileTypes @(".pdf", ".docx")

# Configure SmartScreen:
# Set-EdgeSmartScreen -Enabled $true -ForTrustedDownloads $true -AllowListDomains @("example.com", "microsoft.com")

# Configure Privacy:
# Set-EdgePrivacy -ClearBrowsingDataOnExit $true -ClearCachedImagesAndFilesOnExit $true -BlockThirdPartyCookies $true

# Configure Performance:
# Set-EdgePerformance -EfficiencyModeEnabled $true -StartupBoostEnabled $true -EfficiencyMode "Medium"

# Configure UI:
# Set-EdgeUI -ShowHomeButton $true -FavoritesBarEnabled $false -MouseGestureEnabled $true

# Configure Startup:
# Set-EdgeStartup -RestoreOnStartup "SpecificURLs" -StartupURLs @("https://example.com", "https://microsoft.com")

# Configure Proxy:
# Set-EdgeProxy -Mode "FixedServers" -Server "proxy.example.com:8080" -BypassList @("localhost", "127.0.0.1")

# Configure Extensions:
# Set-EdgeExtensions -InstallAllowlist @("extension1@example.com", "extension2@example.com") -InstallBlocklist @("blocked@example.com") -InstallForcelist @("forced@example.com")

# Configure Search:
# Set-EdgeSearch -MicrosoftSearchEnabled $true -SearchProviderName "Custom Search" -SearchProviderURL "https://search.example.com?q={searchTerms}"

# Configure New Tab Page:
# Set-EdgeNewTabPage -Enabled $true -Location "https://example.com" -QuickLinks @("https://google.com", "https://microsoft.com")

# Configure Edge Website Typo Protection:
# Set-EdgeWebsiteTypoProtection -Enabled $true -ProtectedDomains @("example.com") -ShowWarnings $true -BlockSuspiciousSites $true
