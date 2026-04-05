function Invoke-LFLogged {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [scriptblock]$ScriptBlock,

        [object]$Context
    )

    $start = Get-Date

    Write-LFLog -Level Info -Message "START: $Name" -Context $Context

    try {
        $result = & $ScriptBlock

        $duration = (Get-Date) - $start
        $durationMs = [math]::Round($duration.TotalMilliseconds, 2)

        $durationMsString = $durationMs.ToString([System.Globalization.CultureInfo]::InvariantCulture)

        Write-LFLog -Level Info -Message "END: $Name" -Context $Context -Data @{ DurationMs = $durationMsString }

        return $result
    }
    catch {
        Write-LFLog -Level Error -Message ("FAILED: {0} - {1}" -f $Name, $_.Exception.Message) -Context $Context
        throw
    }
}