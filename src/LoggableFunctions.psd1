@{
    RootModule        = 'LoggableFunctions.psm1'
    ModuleVersion     = '0.1.0'
    GUID              = '7f4b2cb7-0e5c-4f9a-9f6d-5c2e6b8d0a31'
    Author            = 'IntinGtion'
    CompanyName       = 'Personal Project'
    Copyright         = '(c) IntinGtion. All rights reserved.'
    Description       = 'A lightweight PowerShell logging and execution wrapper library.'
    PowerShellVersion = '5.1'

    FunctionsToExport = @(
        'Set-LFLogger',
        'Write-LFLog',
        'New-LFContext',
        'Invoke-LFLogged',
        'Get-LFLogFile'
    )
}