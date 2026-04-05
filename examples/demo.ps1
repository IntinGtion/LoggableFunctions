Import-Module "$PSScriptRoot\..\src\LoggableFunctions.psd1" -Force

$context = New-LFContext -App "LoggableFunctions.Demo"

$logFile = Join-Path $PSScriptRoot "demo.log"

Set-LFLogger -Level Info -FilePath $logFile

$result = Invoke-LFLogged -Name "DemoTask" -Context $context -ScriptBlock {
    Write-LFLog -Level Info -Message "Starting demo work." -Context $context -Data @{ Step = 1 }
    Start-Sleep -Milliseconds 200
    Write-LFLog -Level Warn -Message "This is only a demo warning." -Context $context
    "Demo completed successfully."
}

Write-Host ""
Write-Host "Result: $result"
Write-Host "Log file: $logFile"