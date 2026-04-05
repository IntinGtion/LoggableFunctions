Import-Module "$PSScriptRoot\..\src\LoggableFunctions.psd1" -Force

Describe "LoggableFunctions" {

    BeforeEach {
        $script:testLogFile = Join-Path $env:TEMP "lf_test.log"

        if (Test-Path $script:testLogFile) {
            Remove-Item $script:testLogFile -Force
        }

        Set-LFLogger -Level Info
    }

    It "Write-LFLog should not throw" {
        $ctx = New-LFContext
        { Write-LFLog -Level Info -Message "Test message" -Context $ctx } | Should -Not -Throw
    }

    It "Write-LFLog should create a file when FilePath is configured" {
        Set-LFLogger -Level Info -FilePath $script:testLogFile

        Write-LFLog -Level Info -Message "Test file output"

        Test-Path $script:testLogFile | Should -BeTrue
    }

    It "Write-LFLog should write message content to the file" {
        Set-LFLogger -Level Info -FilePath $script:testLogFile

        Write-LFLog -Level Info -Message "ExpectedMessage"

        $content = Get-Content -Path $script:testLogFile -Raw
        $content | Should -Match "ExpectedMessage"
    }

    It "Write-LFLog should filter messages below configured log level" {
        Set-LFLogger -Level Error -FilePath $script:testLogFile

        Write-LFLog -Level Info -Message "ShouldNotBeWritten"
        Write-LFLog -Level Error -Message "ShouldBeWritten"

        $content = Get-Content -Path $script:testLogFile -Raw

        $content | Should -Not -Match "ShouldNotBeWritten"
        $content | Should -Match "ShouldBeWritten"
    }

    It "Write-LFLog should produce valid JSON when Json is enabled" {
        Set-LFLogger -Level Info -FilePath $script:testLogFile -Json

        Write-LFLog -Level Info -Message "JsonMessage" -Data @{ Step = 1 }

        $content = Get-Content -Path $script:testLogFile -Raw
        $parsed = $content | ConvertFrom-Json

        $parsed.Message | Should -Be "JsonMessage"
        $parsed.Level | Should -Be "Info"
    }

    It "Invoke-LFLogged should write START and END entries" {
        Set-LFLogger -Level Info -FilePath $script:testLogFile
        $ctx = New-LFContext -App "TestApp"

        Invoke-LFLogged -Name "SampleTask" -Context $ctx -ScriptBlock {
            Start-Sleep -Milliseconds 50
        }

        $content = Get-Content -Path $script:testLogFile -Raw

        $content | Should -Match "START: SampleTask"
        $content | Should -Match "END: SampleTask"
    }

    It "Invoke-LFLogged should write an error entry when the script block fails" {
        Set-LFLogger -Level Info -FilePath $script:testLogFile
        $ctx = New-LFContext -App "TestApp"

        {
            Invoke-LFLogged -Name "FailingTask" -Context $ctx -ScriptBlock {
                throw "Boom"
            }
        } | Should -Throw

        $content = Get-Content -Path $script:testLogFile -Raw
        $content | Should -Match "FAILED: FailingTask - Boom"
    }
}