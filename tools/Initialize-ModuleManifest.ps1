function New-Folder {
    param (
        $Path
    )

    if (Get-Item $path -ErrorAction Ignore) {
        Write-Host "Folder $path already exists."
    } else {
        New-Item -Path $path -ItemType Directory | Out-Null
        Write-Host "Folder $path created successfully."
    }
}

function New-File {
    param (
        $Path
    )

    if (Get-Item $path -ErrorAction Ignore) {
        Write-Host "File $path already exists."
    } else {
        New-Item -Path $path -ItemType File | Out-Null
        Write-Host "File $path created successfully."
    }
}

# We cloned our project to /Users/francoislefebvre/gitRepos/SentinelBuddy
$Path = '~/gitRepos/SentinelBuddy'
$ModuleName = 'SentinelBuddy'
$currentYear = (Get-Date).Year

# Create the module and private function directories
#New-Item "$Path/src" -ItemType Directory
New-Folder "$Path/$ModuleName/private"
New-Folder "$Path/$ModuleName/public"
New-Folder "$Path/$ModuleName/en-US" # For about_Help files
New-Folder "$Path/tests"
Write-Host ""

#Create the module and related files
New-File "$Path/$ModuleName/$ModuleName.psm1"
New-File "$Path/$ModuleName/$ModuleName.Format.ps1xml"
New-File "$Path/$ModuleName/en-US/about_$ModuleName.help.txt"
New-File "$Path/tests/$ModuleName.Tests.ps1"
Write-Host ""

$moduleSettings = @{
    RootModule        = '.\SentinelBuddy.psm1'
    Path              = "$Path/$ModuleName/$ModuleName.psd1"
    ModuleVersion     = '0.0.1'
    GUID              = 'a6aba8fa-1fb8-40ae-83c9-7f87ce8d0cfd'
    Author            = 'Francois Lefebvre'
    Copyright         = "MIT License - Copyright © $currentYear Francois Lefebvre"
    Description       = 'Powershell module to facilitate consolidation of detection rules and their data sources'
    CompatiblePSEditions = @('Core')
    PowerShellVersion = '7.0'
    ScriptsToProcess  = @(".\classes\*.ps1")
    FormatsToProcess    = @(".\classesFormat\*.ps1xml")
    FunctionsToExport = @()
    CmdletsToExport   = @()
    VariablesToExport = '*'
    AliasesToExport   = @()
}
# If ModuleManifest exist, update it otherwise create it
if (Get-Item $moduleSettings.Path -ErrorAction Ignore) {
    Write-Host "Updating Module manifest $moduleSettings.Path"
    Update-ModuleManifest @moduleSettings
} else {
    Write-Host "Creating Module manifest $moduleSettings.Path"
    New-ModuleManifest @moduleSettings
}

# Copy the public/exported functions into the public folder, private functions into private folder
