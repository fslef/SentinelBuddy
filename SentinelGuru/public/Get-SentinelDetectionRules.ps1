#Requires -PSEdition Core

# Set the default parameter values for the Write-Information cmdlet
$PSDefaultParameterValues = @{
    "Write-Information:InformationVariable" = "+global:sentinelGuruInfoStream"
}

# Clear the global variable that stores the output of the Write-Information cmdlet
Clear-Variable -Name sentinelGuruInfoStream -Scope global -Force -ErrorAction SilentlyContinue

# Dot Source Helper Scripts
. "$PSScriptRoot\..\private\Add-Helpers.ps1"

# Get Legacy Detection Rules
$temp = Get-GitHubFileList "Azure/Azure-Sentinel" "Detections" -Filter "*.yaml" -Recurse
# $temp | ForEach-Object {
#     $rule = Get-GitHubFile "Azure/Azure-Sentinel" $_.path
#     $rule = ConvertFrom-Yaml $rule
#     $rule = [LegacyDetectionRule]::new($rule)
#     $rule
# }

Write-Host $temp