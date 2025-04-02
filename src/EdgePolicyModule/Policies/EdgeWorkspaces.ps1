<#
.SYNOPSIS
    Configures Microsoft Edge workspaces.
.DESCRIPTION
    Sets the Edge workspaces configuration.
.PARAMETER Workspaces
    Specifies a hashtable of workspaces and their configurations.
.EXAMPLE
    $workspaces = @{
        "Work" = @{
            "DisplayName" = "Work Workspace"
            "StartPage" = "https://work.example.com"
            "Color" = "#0078D7"
        }
    }
    Set-EdgePolicyEdgeWorkspaces -Workspaces $workspaces
#>
function Set-EdgePolicyEdgeWorkspaces {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [hashtable]$Workspaces
    )

    if ($Workspaces.Count -gt 0) {
        $json = $Workspaces | ConvertTo-Json -Depth 10
        Set-EdgePolicy -PolicyName "EdgeWorkspaces" -Type "String" -Value $json
    }
}
