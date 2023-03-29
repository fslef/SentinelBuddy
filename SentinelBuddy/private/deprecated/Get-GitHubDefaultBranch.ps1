#requires -PSEdition Core
function Get-GitHubDefaultBranch {
    param (
        [CmdletBinding()]
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$Repository,
        [Parameter(Position = 1)]
        [string]$PersonalAccessToken
    )

    # Define the API endpoint and access token
    $url = "https://api.github.com/repos/$Repository"

    # Send the HTTP request to the API endpoint
    $headers = @{ "User-Agent" = "PowerShell" }
    if ($PersonalAccessToken) { $headers += @{ "Authorization" = "Bearer $PersonalAccessToken" } }
    $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get -ContentType "application/vnd.github.v3.raw"

    # Get the name of the default branch
    $default_branch = $response.default_branch

    # Print the name of the default branch
    Write-Host "Default branch: $default_branch"

    # Return the name of the default branch (optional)
    return $default_branch
}
