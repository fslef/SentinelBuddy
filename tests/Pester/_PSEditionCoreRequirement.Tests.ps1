Describe "PowerShell script requirements" {
    $ps1Files = Get-ChildItem -Path "$PSScriptRoot\..\SentinelBuddy\private\*.ps1" -Recurse
    $ps1Files += Get-ChildItem -Path "$PSScriptRoot\..\SentinelBuddy\Public\*.ps1" -Recurse

    ForEach ($file in $ps1Files) {
        Context "File $($file.FullName)" {
            It "should require PowerShell Core edition" {
                # Arrange
                $content = Get-Content -Path $file.FullName

                # Act
                $result = $content | Select-String "#requires -PSEdition Core"

                # Assert
                $result | Should Not BeNullOrEmpty
            }
        }
    }
}
