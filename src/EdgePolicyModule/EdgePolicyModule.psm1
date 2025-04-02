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

# Import Content Settings policies
. $PSScriptRoot\Policies\DefaultJavaScriptSetting.ps1
. $PSScriptRoot\Policies\DefaultCookiesSetting.ps1

# Import HTTP Authentication policies
. $PSScriptRoot\Policies\AuthSchemes.ps1
. $PSScriptRoot\Policies\BasicAuthOverHttpEnabled.ps1

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

# Export all functions
Export-ModuleMember -Function *
