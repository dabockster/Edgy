<#
.SYNOPSIS
    Configures Microsoft Edge related website sets.
.DESCRIPTION
    Sets the related website sets in Microsoft Edge.
.PARAMETER WebsiteSets
    Specifies a hashtable of website sets and their configurations.
.EXAMPLE
    $websiteSets = @{
        "example.com" = @{
            "RelatedSites" = @("example2.com", "example3.com")
            "Description" = "Example websites"
        }
    }
    Set-EdgePolicyRelatedWebsiteSets -WebsiteSets $websiteSets
#>
function Set-EdgePolicyRelatedWebsiteSets {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [hashtable]$WebsiteSets
    )

    if ($WebsiteSets.Count -gt 0) {
        $json = $WebsiteSets | ConvertTo-Json -Depth 10
        Set-EdgePolicy -PolicyName "RelatedWebsiteSets" -Type "String" -Value $json
    }
}
