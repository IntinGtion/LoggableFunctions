function Format-LFMessage {
    [CmdletBinding()]
    param(
        [string]$Level,
        [string]$Message,
        [object]$Context,
        [hashtable]$Data
    )

    $timestamp = (Get-Date).ToString('o')

    if ($script:LFLogger.Json) {
        $payload = [ordered]@{
            Timestamp = $timestamp
            Level     = $Level
            Message   = $Message
            Context   = $Context
            Data      = $Data
        }

        return ($payload | ConvertTo-Json -Depth 5 -Compress)
    }

    $parts = @()
    $parts += $timestamp
    $parts += "[$Level]"
    $parts += $Message

    if ($Context) {
        if ($Context.PSObject.Properties['App'] -and $Context.App) {
            $parts += "[App=$($Context.App)]"
        }

        if ($Context.PSObject.Properties['CorrelationId'] -and $Context.CorrelationId) {
            $parts += "[CorrelationId=$($Context.CorrelationId)]"
        }
    }

    if ($Data -and $Data.Count -gt 0) {
        $dataString = ($Data.GetEnumerator() | Sort-Object Name | ForEach-Object {
            '{0}={1}' -f $_.Key, $_.Value
        }) -join '; '

        $parts += "[Data=$dataString]"
    }

    return ($parts -join ' ')
}