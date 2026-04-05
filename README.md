# LoggableFunctions

A lightweight PowerShell logging and execution wrapper library.

## Features

- Plain text and JSON logging
- Context support (`CorrelationId`, `App`, `User`, `Machine`)
- Execution wrapper with duration tracking
- Configurable log level filtering
- Designed for Windows PowerShell 5.1 and PowerShell 7+

## Project Structure

```text
LoggableFunctions/
├── src/
│   ├── LoggableFunctions.psd1
│   ├── LoggableFunctions.psm1
│   ├── Public/
│   └── Private/
├── tests/
└── examples/

## Example

Import-Module .\src\LoggableFunctions.psd1

$ctx = New-LFContext -App "DemoApp"

Set-LFLogger -Level Info -FilePath ".\log.txt"

Invoke-LFLogged -Name "TestRun" -Context $ctx -ScriptBlock {
    Write-LFLog -Level Info -Message "Hello World" -Context $ctx -Data @{ Step = 1 }
}

## Running Tests

Invoke-Pester .\tests

## Notes

This project is intentionally written in a PowerShell 5.1-compatible style while aiming to remain usable in PowerShell 7+ as well.

---

# 2) `examples/demo.ps1`

Die Datei sollte auf keinen Fall leer sein. So ist sie direkt nützlich:

```powershell
Import-Module "$PSScriptRoot\..\src\LoggableFunctions.psd1" -Force

$context = New-LFContext -App "LoggableFunctions.Demo"

Set-LFLogger -Level Info -FilePath "$PSScriptRoot\demo.log"

Invoke-LFLogged -Name "DemoTask" -Context $context -ScriptBlock {
    Write-LFLog -Level Info -Message "Starting demo work." -Context $context -Data @{ Step = 1 }
    Start-Sleep -Milliseconds 200
    Write-LFLog -Level Warn -Message "This is only a demo warning." -Context $context
    "Demo completed successfully."
}