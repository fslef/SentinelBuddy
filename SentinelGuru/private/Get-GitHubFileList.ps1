function Get-GitHubFileList {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Repository,

        [Parameter(Mandatory = $true, Position = 1)]
        [string]$FolderPath,

        [Parameter()]
        [string]$Token,

        [Parameter()]
        [string]$Filter = '*.*',

        [Parameter()]
        [switch]$Recurse
    )

    # Dot Source Helper Scripts
    . "$PSScriptRoot\..\private\Add-Helpers.ps1"

    # Set up the API endpoint and repository information
    $endpoint = "https://api.github.com"
    #$repository = "$($Repository -split '/')"
    $headers = @{
        "User-Agent" = "PowerShell"
    }

    if ($Token) {
        $headers.Add("Authorization", "Bearer $Token")
    }

    # Check if the GitHub API rate limit has been exceeded
    $rateLimit = Measure-GitHubRateLimit
    if ($rateLimit.Remaining -lt 1) {
        Write-Error "GitHub API rate limit exceeded. Limit will reset at $ratelimit.Reset."
        return
    }
    else {
        Write-Verbose "Remaining requests: $($rateLimit.Remaining). Reset at: $($rateLimit.Reset)"
    }

    # Build the file search path
    $searchPath = "$FolderPath/$Filter"

    # Send a GET request to the API endpoint to retrieve the contents of the folder
    $url = "$endpoint/repos/$repository/contents/$FolderPath"
    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ErrorAction Stop
    }
    catch {
        Write-Error $_.Exception.Message
        return
    }

    # Create an array to store the file URLs
    $fileUrls = @()

    # Loop through each item in the folder response
    foreach ($item in $response) {
        # If the item is a file and matches the search filter, add its URL to the array
        if ($item.type -eq "file" -and $item.name -like $Filter) {
            $fileUrls += $item.url
        }
        # If the item is a directory and recursion is enabled, recursively call the function
        elseif ($item.type -eq "dir" -and $Recurse) {
            # Build the parameter list for the nested function call
            $params = @{
                Repository = $Repository
                FolderPath = $item.path
            }
            if ($Filter) {
                $params.Add("Filter", $Filter)
            }
            if ($Recurse) {
                $params.Add("Recurse", $Recurse)
            }
            if ($Token) {
                $params.Add("Token", $Token)
            }

            # Recursively call the function with the built parameter list
            $fileUrls += (Get-GitHubFileList @params)
        }
    }

    # Return the file URLs
    return $fileUrls
}
