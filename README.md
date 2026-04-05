# LoggableFunctions

A lightweight PowerShell logging and execution wrapper library.

## Why this project exists

This project was created as a small, practical PowerShell portfolio project to demonstrate:

- clean module structure
- reusable logging patterns
- context-aware log output
- Pester-based testing
- compatibility-minded PowerShell development

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
```

## Example

```powershell
Import-Module .\src\LoggableFunctions.psd1

$ctx = New-LFContext -App "DemoApp"

Set-LFLogger -Level Info -FilePath ".\log.txt"

Invoke-LFLogged -Name "TestRun" -Context $ctx -ScriptBlock {
    Write-LFLog -Level Info -Message "Hello World" -Context $ctx -Data @{ Step = 1 }
}
```

## Demo Script

You can run the included demo script like this:

```powershell
.\examples\demo.ps1
```

## Running Tests

```powershell
Import-Module Pester -MinimumVersion 5.0 -Force
Invoke-Pester .\tests
```

## Contineous Integration

This repository uses GitHub Actions to run the test suite on:

- Windows PowerShell 5.1
- PowerShell 7

## Notes

This project is intentionally written in a PowerShell 5.1-compatible style while aiming to remain usable in PowerShell 7+ as well.