Set-StrictMode -Version Latest

$script:LFLogger = @{
    Level    = 'Info'
    FilePath = $null
    Json     = $false
}

Get-ChildItem -Path (Join-Path $PSScriptRoot 'Private\*.ps1') -File | ForEach-Object {
    . $_.FullName
}

Get-ChildItem -Path (Join-Path $PSScriptRoot 'Public\*.ps1') -File | ForEach-Object {
    . $_.FullName
}