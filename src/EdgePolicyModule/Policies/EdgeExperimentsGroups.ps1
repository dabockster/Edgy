<#
.SYNOPSIS
    Configures Microsoft Edge experiment groups.
.DESCRIPTION
    Sets the Edge experiment groups.
.PARAMETER Groups
    Specifies an array of experiment groups.
.EXAMPLE
    Set-EdgePolicyEdgeExperimentsGroups -Groups @("group1", "group2")
#>
function Set-EdgePolicyEdgeExperimentsGroups {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Groups
    )

    if ($Groups.Count -gt 0) {
        Set-EdgePolicy -PolicyName "EdgeExperimentsGroups" -Type "MultiString" -Value $Groups
    }
}
