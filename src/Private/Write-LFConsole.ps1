function Write-LFConsole {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Entry
    )

    Write-Host $Entry
}