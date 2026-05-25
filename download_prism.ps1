$ErrorActionPreference = 'Stop'
# Get latest release info from GitHub API
$latestRelease = Invoke-RestMethod -Uri 'https://api.github.com/repos/PrismLauncher/PrismLauncher/releases/latest' -Headers @{ 'User-Agent' = 'curl' }
# Find portable zip asset
$zipAsset = $latestRelease.assets | Where-Object { $_.name -like '*Windows-MSVC-Portable*.zip' } | Select-Object -First 1
if (-not $zipAsset) { Write-Error 'Portable zip asset not found in latest release.' }
$downloadUrl = $zipAsset.browser_download_url
$zipPath = Join-Path -Path $PSScriptRoot -ChildPath $zipAsset.name
Write-Host "Downloading $($zipAsset.name) from $downloadUrl..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath -Headers @{ 'User-Agent' = 'curl' }
# Extract to folder named PrismLauncher
$extractDir = Join-Path -Path $PSScriptRoot -ChildPath 'PrismLauncher'
if (-not (Test-Path $extractDir)) { New-Item -ItemType Directory -Path $extractDir | Out-Null }
Write-Host "Extracting $($zipAsset.name) to $extractDir..."
Expand-Archive -Path $zipPath -DestinationPath $extractDir -Force
Write-Host "Prism Launcher has been set up at $extractDir"
# Clean up zip file
Remove-Item $zipPath -Force
