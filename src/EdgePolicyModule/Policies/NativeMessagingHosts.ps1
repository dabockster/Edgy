<#
.SYNOPSIS
    Configures Microsoft Edge native messaging hosts.
.DESCRIPTION
    Sets the native messaging hosts in Microsoft Edge.
.PARAMETER Hosts
    Specifies a hashtable of native messaging hosts and their configurations.
.EXAMPLE
    $hosts = @{
        "com.example.host" = @{
            "Path" = "C:\Program Files\Example\host.exe"
            "Type" = "stdio"
        }
    }
    Set-EdgePolicyNativeMessagingHosts -Hosts $hosts
#>
function Set-EdgePolicyNativeMessagingHosts {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [hashtable]$Hosts
    )

    if ($Hosts.Count -gt 0) {
        $json = $Hosts | ConvertTo-Json -Depth 10
        Set-EdgePolicy -PolicyName "NativeMessagingHosts" -Type "String" -Value $json
    }
}
