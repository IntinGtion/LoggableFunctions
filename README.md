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
```