Describe "Get-GitHubFile" {
    Context "When the specified file exists in the repository" {
        It "Should return the contents of the file" {
            $repository = "owner/repo"
            $filePath = "path/to/file.txt"
            $expectedContent = "Hello, world!"

            # Stub the Invoke-RestMethod call to return a mock response
            $mockResponse = @{
                content = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($expectedContent))
                encoding = "base64"
            }
            $mockedFunction = {
                return $mockResponse
            }
            $scriptBlock = [ScriptBlock]::Create($mockedFunction.ToString().Replace("PLACEHOLDER", $mockResponse | ConvertTo-Json))
            $function:Get-GitHubFile = $scriptBlock

            # Call the function and verify that the contents of the file are returned
            $result = Get-GitHubFile -Repository $repository -FilePath $filePath
            $result.Should().Be($expectedContent)
        }
    }

    Context "When the specified file does not exist in the repository" {
        It "Should return an error message" {
            $repository = "owner/repo"
            $filePath = "path/to/nonexistent/file.txt"

            # Stub the Invoke-RestMethod call to return a mock error response
            $mockResponse = @{
                message = "Not Found"
            }
            $mockedFunction = {
                return $mockResponse
            }
            $scriptBlock = [ScriptBlock]::Create($mockedFunction.ToString().Replace("PLACEHOLDER", $mockResponse | ConvertTo-Json))
            $function:Get-GitHubFile = $scriptBlock

            # Call the function and verify that an error message is returned
            $result = Get-GitHubFile -Repository $repository -FilePath $filePath
            $result.Exception.Message.Should().Be("Not Found")
        }
    }

    Context "When the specified file has an unsupported encoding type" {
        It "Should return an error message" {
            $repository = "owner/repo"
            $filePath = "path/to/file.bin"

            # Stub the Invoke-RestMethod call to return a mock response with an unsupported encoding type
            $mockResponse = @{
                content = [System.Convert]::ToBase64String([byte[]]@(0x00, 0x01, 0x02))
                encoding = "binary"
            }
            $mockedFunction = {
                return $mockResponse
            }
            $scriptBlock = [ScriptBlock]::Create($mockedFunction.ToString().Replace("PLACEHOLDER", $mockResponse | ConvertTo-Json))
            $function:Get-GitHubFile = $scriptBlock

            # Call the function and verify that an error message is returned
            $result = Get-GitHubFile -Repository $repository -FilePath $filePath
            $result.Exception.Message.Should().Be("Unsupported encoding type: binary")
        }
    }

    Context "When the API rate limit has been exceeded" {
        It "Should return an error message" {
            $repository = "owner/repo"
            $filePath = "path/to/file.txt"
            $token = "placeholder"

            # Stub the Measure-GitHubRateLimit function to return a mock rate limit
            $mockRateLimit = @{
                Remaining = 0
                Reset = "2022-01-01T00:00:00Z"
            }
            $mockedFunction = {
                return $mockRateLimit
            }
        }
    }
}