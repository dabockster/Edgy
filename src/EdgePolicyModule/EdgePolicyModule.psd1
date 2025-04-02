@{
    RootModule = 'EdgePolicyModule.psm1'
    ModuleVersion = '1.0.0'
    GUID = '7e4b6e4a-1234-5678-9012-345678901234'
    Author = 'Your Name'
    CompanyName = 'Your Company'
    Copyright = '(c) 2025. All rights reserved.'
    Description = 'PowerShell module for managing Microsoft Edge policies'
    PowerShellVersion = '7.0'
    RequiredModules = @()
    FunctionsToExport = @(
        'New-EdgePolicyPath',
        'Set-EdgePolicy',
        'Remove-EdgePolicy',
        'Get-EdgePolicy',
        'Set-EdgePolicyAddressBarEditingEnabled',
        'Set-EdgePolicyAddressBarMicrosoftSearchInBingProviderEnabled',
        'Set-EdgePolicyDownloadDirectory',
        'Set-EdgePolicyDownloadRestrictions',
        'Set-EdgePolicyNewTabPageContentEnabled',
        'Set-EdgePolicyNewTabPageLocation',
        'Set-EdgePolicyNewTabPageManagedQuickLinks',
        'Set-EdgePolicySmartScreenEnabled',
        'Set-EdgePolicySmartScreenForTrustedDownloadsEnabled',
        'Set-EdgePolicySmartScreenAllowListDomains',
        'Set-EdgePolicyClearBrowsingDataOnExit',
        'Set-EdgePolicyClearCachedImagesAndFilesOnExit',
        'Set-EdgePolicyBlockThirdPartyCookies',
        'Set-EdgePolicyEfficiencyModeEnabled',
        'Set-EdgePolicyStartupBoostEnabled',
        'Set-EdgePolicyEfficiencyMode',
        'Set-EdgePolicyShowHomeButton',
        'Set-EdgePolicyFavoritesBarEnabled',
        'Set-EdgePolicyMouseGestureEnabled',
        'Set-EdgePolicyExtensionInstallAllowlist',
        'Set-EdgePolicyExtensionInstallBlocklist',
        'Set-EdgePolicyDefaultJavaScriptSetting',
        'Set-EdgePolicyDefaultCookiesSetting',
        'Set-EdgePolicyAuthSchemes',
        'Set-EdgePolicyBasicAuthOverHttpEnabled',
        'Set-EdgePolicyPDFReaderEnabled',
        'Set-EdgePolicyPDFReaderViewXFAAllowedFileHash',
        'Set-EdgePolicyCACertificateManagementAllowed',
        'Set-EdgePolicyCACertificates',
        'Set-EdgePolicyAutomaticProfileSwitchingSiteList',
        'Set-EdgePolicyDefaultSearchProviderName',
        'Set-EdgePolicyDefaultSearchProviderURL',
        'Set-EdgePolicyProxyMode',
        'Set-EdgePolicyProxyServer',
        'Set-EdgePolicyProxyPacUrl',
        'Set-EdgePolicyBlockExternalExtensions',
        'Set-EdgePolicyDefaultSearchProviderPrepopulate',
        'Set-EdgePolicyProxyBypassList',
        'Set-EdgePolicyProxySettingsPerOrigin',
        'Set-EdgePolicyExtensionAllowedTypes',
        'Set-EdgePolicyExtensionInstallForcelist',
        'Set-EdgePolicyExtensionInstallBlocklistExceptions'
    )
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()
}
