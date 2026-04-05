function New-LFContext {
    [CmdletBinding()]
    param(
        [string]$App = 'DefaultApp',
        [string]$CorrelationId
    )

    if (-not $CorrelationId) {
        $CorrelationId = [guid]::NewGuid().ToString()
    }

    [pscustomobject]@{
        App           = $App
        CorrelationId = $CorrelationId
        Machine       = $env:COMPUTERNAME
        User          = $env:USERNAME
    }
}