#Requires -PSEdition Core

# Load classes
. "$PSScriptRoot\..\Private\_Class_LegacyDetectionRule.ps1"

# Load cmdlets
. "$PSScriptRoot\..\Private\Get-GitHubContent.ps1"
. "$PSScriptRoot\..\Private\Get-GitHubFileList.ps1"
. "$PSScriptRoot\..\Private\Measure-GitHubRateLimit.ps1"
. "$PSScriptRoot\..\Private\Write-HostPadded.ps1"
