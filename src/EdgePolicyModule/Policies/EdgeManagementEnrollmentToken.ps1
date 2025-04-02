<#
.SYNOPSIS
    Configures Microsoft Edge management enrollment token.
.DESCRIPTION
    Sets the enrollment token for Microsoft Edge management.
.PARAMETER Token
    Specifies the enrollment token for Microsoft Edge management.
.EXAMPLE
    Set-EdgePolicyEdgeManagementEnrollmentToken -Token "your-token-here"
#>
function Set-EdgePolicyEdgeManagementEnrollmentToken {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Token
    )

    Set-EdgePolicy -PolicyName "EdgeManagementEnrollmentToken" -Type "String" -Value $Token
}
