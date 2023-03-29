function Get-GitHubFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Repository,

        [Parameter(Mandatory = $true, Position = 1)]
        [string]$FilePath,

        [Parameter()]
        [string]$Token
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

    # Check the rate limit before making the API call
    $rateLimit = Measure-GitHubRateLimit
    if ($rateLimit.Remaining -lt 1) {
        Write-Error "GitHub API rate limit exceeded. Limit will reset at $($rateLimit.Reset)."
        return
    }

    # Send a GET request to the API endpoint to retrieve the contents of the file
    $url = "$endpoint/repos/$repository/contents/$FilePath"
    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ErrorAction Stop
    }
    catch {
        Write-Error $_.Exception.Message
        return
    }

    # Check if the response is an error message
    if ($response.message) {
        Write-Error $response.message
        return
    }

    # Decode the content of the file
    if ($response.encoding -eq "base64") {
        $content = [System.Convert]::FromBase64String($response.content)
    }
    else {
        Write-Error "Unsupported encoding type: $($response.encoding)"
        return
    }

    # Check if the decoded content is a valid UTF8 string
    try {
        $decodedContent = [System.Text.Encoding]::UTF8.GetString($content)
    }
    catch {
        Write-Error "Failed to decode content as UTF8 string"
        return
    }

    # Return the decoded content
    return $decodedContent
}