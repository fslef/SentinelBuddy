function Measure-GitHubRateLimit {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$Token = ""
    )

    # Dot Source Helper Scripts
    . "$PSScriptRoot\..\private\Add-Helpers.ps1"


    if ($Token -eq "") {
        Write-Warning "No GitHub access token specified. Rate limit will be based on IP address only."
    }

    $headers = @{}
    if ($Token -ne "") {
        $headers["Authorization"] = "token $Token"
    }

    $response = Invoke-RestMethod -Uri "https://api.github.com/rate_limit" -Headers $headers

    $rateLimit = [PSCustomObject]@{
        Limit     = $response.resources.core.limit
        Remaining = $response.resources.core.remaining
        Reset     = (Get-Date ([DateTimeOffset]::FromUnixTimeSeconds($response.resources.core.reset)).UtcDateTime.ToLocalTime()).ToString("yyyy-MM-dd HH:mm:ss")
    }

    return $rateLimit
}
