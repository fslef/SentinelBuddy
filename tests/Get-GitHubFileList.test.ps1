Describe 'Get-GitHubFileList' {
    Context 'When filtering by filename' {
        It 'Returns the correct file' {
            $ownerRepo = 'octocat/Hello-World'
            $path = '/'
            $filename = 'README.md'
            $token = $env:GITHUB_TOKEN

            $result = Get-GitHubFiles -OwnerRepo $ownerRepo -Path $path -Filename $filename -Token $token

            $expected = "$ownerRepo/$path$filename"
            $result | Should -Be $expected
        }
    }

    Context 'When filtering by extension' {
        It 'Returns the correct files' {
            $ownerRepo = 'octocat/Hello-World'
            $path = '/'
            $extension = 'md'
            $token = $env:GITHUB_TOKEN

            $result = Get-GitHubFiles -OwnerRepo $ownerRepo -Path $path -Extension $extension -Token $token

            $expected = @(
                "$ownerRepo/$path$extension/README.md",
                "$ownerRepo/$path$extension/CONTRIBUTING.md",
                "$ownerRepo/$path$extension/CODE_OF_CONDUCT.md",
                "$ownerRepo/$path$extension/LICENSE.md"
            )

            $result | Should -Contain $expected
        }
    }

    Context 'When the rate limit is exceeded' {
        It 'Displays a warning and exits' {
            $ownerRepo = 'octocat/Hello-World'
        }
    }

}
