# EdgePolicyModule.psm1
# Module manifest for EdgePolicyModule

# Import core functions
. $PSScriptRoot\Core\CoreFunctions.ps1

# Import Address Bar policies
. $PSScriptRoot\Policies\AddressBarEditingEnabled.ps1
. $PSScriptRoot\Policies\AddressBarMicrosoftSearchInBingProviderEnabled.ps1

# Import Downloads policies
. $PSScriptRoot\Policies\DownloadDirectory.ps1
. $PSScriptRoot\Policies\DownloadRestrictions.ps1

# Import New Tab Page policies
. $PSScriptRoot\Policies\NewTabPageContentEnabled.ps1
. $PSScriptRoot\Policies\NewTabPageLocation.ps1
. $PSScriptRoot\Policies\NewTabPageManagedQuickLinks.ps1

# Import SmartScreen policies
. $PSScriptRoot\Policies\SmartScreenEnabled.ps1
. $PSScriptRoot\Policies\SmartScreenForTrustedDownloadsEnabled.ps1
. $PSScriptRoot\Policies\SmartScreenAllowListDomains.ps1

# Import Privacy policies
. $PSScriptRoot\Policies\ClearBrowsingDataOnExit.ps1
. $PSScriptRoot\Policies\ClearCachedImagesAndFilesOnExit.ps1
. $PSScriptRoot\Policies\BlockThirdPartyCookies.ps1

# Import Performance policies
. $PSScriptRoot\Policies\EfficiencyModeEnabled.ps1
. $PSScriptRoot\Policies\StartupBoostEnabled.ps1
. $PSScriptRoot\Policies\EfficiencyMode.ps1

# Import UI Features policies
. $PSScriptRoot\Policies\ShowHomeButton.ps1
. $PSScriptRoot\Policies\FavoritesBarEnabled.ps1
. $PSScriptRoot\Policies\MouseGestureEnabled.ps1

# Import Extensions policies
. $PSScriptRoot\Policies\ExtensionInstallAllowlist.ps1
. $PSScriptRoot\Policies\ExtensionInstallBlocklist.ps1
. $PSScriptRoot\Policies\BlockExternalExtensions.ps1
. $PSScriptRoot\Policies\ExtensionAllowedTypes.ps1
. $PSScriptRoot\Policies\ExtensionInstallForcelist.ps1
. $PSScriptRoot\Policies\ExtensionInstallBlocklistExceptions.ps1

# Import Content Settings policies
. $PSScriptRoot\Policies\DefaultJavaScriptSetting.ps1
. $PSScriptRoot\Policies\DefaultCookiesSetting.ps1

# Import HTTP Authentication policies
. $PSScriptRoot\Policies\AuthSchemes.ps1
. $PSScriptRoot\Policies\BasicAuthOverHttpEnabled.ps1
. $PSScriptRoot\Policies\AllAuthSchemesAllowedForOrigins.ps1
. $PSScriptRoot\Policies\DelegateAuthSchemesAllowedForOrigins.ps1

# Import PDF Reader policies
. $PSScriptRoot\Policies\PDFReaderEnabled.ps1
. $PSScriptRoot\Policies\PDFReaderViewXFAAllowedFileHash.ps1

# Import Certificate Management policies
. $PSScriptRoot\Policies\CACertificateManagementAllowed.ps1
. $PSScriptRoot\Policies\CACertificates.ps1

# Import Identity and Sign-in policies
. $PSScriptRoot\Policies\AutomaticProfileSwitchingSiteList.ps1

# Import Default Search Provider policies
. $PSScriptRoot\Policies\DefaultSearchProviderName.ps1
. $PSScriptRoot\Policies\DefaultSearchProviderURL.ps1

# Import Proxy Configuration policies
. $PSScriptRoot\Policies\ProxyMode.ps1
. $PSScriptRoot\Policies\ProxyServer.ps1
. $PSScriptRoot\Policies\ProxyPacUrl.ps1

# Import Network settings policies
. $PSScriptRoot\Policies\NetworkPredictionOptions.ps1
. $PSScriptRoot\Policies\NetworkServiceSandboxEnabled.ps1

# Import Password Protection policies
. $PSScriptRoot\Policies\PasswordManagerEnabled.ps1
. $PSScriptRoot\Policies\PasswordProtectionAllowed.ps1

# Import Scareware Blocker policies
. $PSScriptRoot\Policies\ScarewareBlockerProtectionEnabled.ps1

# Import Screen Capture policies
. $PSScriptRoot\Policies\ScreenCaptureAllowed.ps1

# Import WebRTC policies
. $PSScriptRoot\Policies\WebRtcLocalIpsAllowedUrls.ps1

# Import Application Guard policies
. $PSScriptRoot\Policies\ApplicationGuardContainerProxy.ps1

# Import Private Network policies
. $PSScriptRoot\Policies\PrivateNetworkRequestPolicy.ps1

# Import Sleeping Tabs policies
. $PSScriptRoot\Policies\SleepingTabsEnabled.ps1
. $PSScriptRoot\Policies\SleepingTabsDelaySeconds.ps1

# Import Edge Management policies
. $PSScriptRoot\Policies\EdgeManagementEnabled.ps1
. $PSScriptRoot\Policies\EdgeManagementEnrollmentToken.ps1

# Import Browser Settings policies
. $PSScriptRoot\Policies\DefaultBrowserSettingEnabled.ps1
. $PSScriptRoot\Policies\DefaultBrowserSettingsCampaignEnabled.ps1

# Import Update Settings policies
. $PSScriptRoot\Policies\ComponentUpdatesEnabled.ps1
. $PSScriptRoot\Policies\BrowserCodeIntegritySetting.ps1

# Import Kiosk Mode policies
. $PSScriptRoot\Policies\KioskAddressBarEditingEnabled.ps1
. $PSScriptRoot\Policies\KioskDeleteDownloadsOnExit.ps1

# Import Profile Management policies
. $PSScriptRoot\Policies\EdgeDefaultProfileEnabled.ps1

# Import Casting policies
. $PSScriptRoot\Policies\CastEnabled.ps1
. $PSScriptRoot\Policies\CastScreenEnabled.ps1

# Import Immersive Reader policies
. $PSScriptRoot\Policies\ImmersiveReaderEnabled.ps1
. $PSScriptRoot\Policies\ImmersiveReaderAllowedDomains.ps1

# Import Native Messaging policies
. $PSScriptRoot\Policies\NativeMessagingEnabled.ps1
. $PSScriptRoot\Policies\NativeMessagingHosts.ps1

# Import Printing policies
. $PSScriptRoot\Policies\CloudPrintEnabled.ps1
. $PSScriptRoot\Policies\CloudPrintURL.ps1

# Import Related Website Sets policies
. $PSScriptRoot\Policies\RelatedWebsiteSetsEnabled.ps1
. $PSScriptRoot\Policies\RelatedWebsiteSets.ps1

# Import Experimentation policies
. $PSScriptRoot\Policies\EdgeExperimentsEnabled.ps1
. $PSScriptRoot\Policies\EdgeExperimentsGroups.ps1

# Import Edge Workspaces policies
. $PSScriptRoot\Policies\EdgeWorkspacesEnabled.ps1
. $PSScriptRoot\Policies\EdgeWorkspaces.ps1

# Export all functions
Export-ModuleMember -Function *
