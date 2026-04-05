function Set-LFLogger {
    [CmdletBinding()]
    param(
        [ValidateSet('Trace','Debug','Info','Warn','Error')]
        [string]$Level = 'Info',

        [string]$FilePath,

        [switch]$Json
    )

    $script:LFLogger.Level = $Level
    $script:LFLogger.FilePath = $FilePath
    $script:LFLogger.Json = $Json.IsPresent
}