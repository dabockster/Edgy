<#
.SYNOPSIS
    Configures Microsoft Edge PDF reader XFA file hash allow list.
.DESCRIPTION
    Sets the list of allowed XFA file hashes in the PDF reader.
.PARAMETER FileHashes
    Specifies an array of allowed XFA file hashes.
.EXAMPLE
    Set-EdgePolicyPDFReaderViewXFAAllowedFileHash -FileHashes @("hash1", "hash2")
#>
function Set-EdgePolicyPDFReaderViewXFAAllowedFileHash {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$FileHashes
    )

    if ($FileHashes.Count -gt 0) {
        Set-EdgePolicy -PolicyName "PDFReaderViewXFAAllowedFileHash" -Type "MultiString" -Value $FileHashes
    }
}
