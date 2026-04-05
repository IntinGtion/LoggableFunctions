function Write-LFLog {
    [CmdletBinding()]
    param(
        [ValidateSet('Trace','Debug','Info','Warn','Error')]
        [string]$Level,

        [Parameter(Mandatory = $true)]
        [string]$Message,

        [object]$Context,

        [hashtable]$Data
    )

    $levelMap = @{
        Trace = 0
        Debug = 1
        Info  = 2
        Warn  = 3
        Error = 4
    }

    $configuredLevel = $script:LFLogger.Level

    if ($levelMap[$Level] -lt $levelMap[$configuredLevel]) {
        return
    }

    $entry = Format-LFMessage -Level $Level -Message $Message -Context $Context -Data $Data

    Write-LFConsole -Entry $entry

    if ($script:LFLogger.FilePath) {
        Write-LFFile -Entry $entry
    }
}