# Make an HTTP GET request to the GitHub API to get the contents of the repository
$url = "https://api.github.com/repos/Azure/Azure-Sentinel/contents/Solutions"
$response = Invoke-RestMethod $url

# Loop through the response to display the file and folder names
foreach ($item in $response) {
    if ($item.type -eq "dir") {
        Write-Host "Directory: $($item.name)"
    } else {
        Write-Host "File: $($item.name)"
    }
}
