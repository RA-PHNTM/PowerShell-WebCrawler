# PowerShell Web Crawler

# Crawl web page/retrieve links
function Get-LinksFromPage {
    param (
        [string]$url
    )

    try {
        # web request
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing

        # Extract links
        $links = $response.Links | ForEach-Object { $_.href }

        
        return $links
    } catch {
        Write-Error "Failed to access $url"
    }
}


# Prompt for the URL/IP
$destination = Read-Host "Insert destination"

# Check/validate input
if (-not $destination.StartsWith("http")) {
    $destination = "http://$destination"
}

# Crawl
$links = Get-LinksFromPage -url $destination

if ($links) {
    Write-Output "Found the following links from ${destination}:"
    $links
} else {
    Write-Output "No links found/unable to retrieve page."
}
