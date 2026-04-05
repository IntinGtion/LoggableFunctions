function Write-LFFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Entry
    )

    $path = $script:LFLogger.FilePath

    if (-not $path) {
        return
    }

    $directory = Split-Path -Path $path -Parent

    if ($directory -and -not (Test-Path -Path $directory)) {
        New-Item -Path $directory -ItemType Directory -Force | Out-Null
    }

    Add-Content -Path $path -Value $Entry
}