Describe "Get-GitHubDefaultBranch" {
    Context "Given a valid repository name" {
        It "should return the name of the default branch" {
            # Arrange
            $repo = "Azure/Azure-Sentinel"

            # Act
            $result = Get-GitHubDefaultBranch -Repository $repo

            # Assert
            $result | Should Not BeNullOrEmpty
        }

        It "should verify that the GitHub API is reachable" {
            # Arrange
            $repo = "Azure/Azure-Sentinel"

            # Act
            $result = { Get-GitHubDefaultBranch -Repository $repo } -TimeoutSeconds 10

            # Assert
            $result -NotMatch "Invoke-RestMethod : The underlying connection was closed"
        }
    }

    Context "Given an invalid repository name" {
        It "should throw an error" {
            # Arrange
            $repo = "invalid_repo"

            # Act
            $result = { Get-GitHubDefaultBranch -Repository $repo -ErrorAction SilentlyContinue }

            # Assert
            $result.Exception.Message | Should Match "404 Not Found"
        }
    }

    Context "Given a repository name and a personal access token" {
        It "should use the access token in the HTTP request headers" {
            # Arrange
            $repo = "Azure/Azure-Sentinel"
            $token = "my_personal_access_token"

            # Act
            $result = Get-GitHubDefaultBranch -Repository $repo -PersonalAccessToken $token

            # Assert
            $result | Should Not BeNullOrEmpty
        }
    }

    Context "Given a repository name and no personal access token" {
        It "should use the default HTTP request headers" {
            # Arrange
            $repo = "Azure/Azure-Sentinel"

            # Act
            $result = Get-GitHubDefaultBranch -Repository $repo

            # Assert
            $result | Should Not BeNullOrEmpty
        }
    }
}

