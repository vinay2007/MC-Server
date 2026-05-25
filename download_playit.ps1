$ErrorActionPreference = "Stop"
$Headers = @{ "User-Agent" = "MinecraftNetworkUpdater/1.0" }
$PlayitUrl = "https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-windows-x86_64-signed.exe"
$Dest = "d:\MC-Server\Minecraft_Network\playit.exe"

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "Downloading Playit.gg Windows Client" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

if (-not (Test-Path "d:\MC-Server\Minecraft_Network")) {
    New-Item -ItemType Directory -Path "d:\MC-Server\Minecraft_Network" | Out-Null
}

Write-Host "Downloading from GitHub releases..." -ForegroundColor Gray
Invoke-WebRequest -Uri $PlayitUrl -OutFile $Dest -Headers $Headers
Write-Host "Playit.exe saved successfully to $Dest!" -ForegroundColor Green

Write-Host "`n=============================================" -ForegroundColor Cyan
Write-Host "Launching Playit Tunnel Agent" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# Start playit.exe in the background
$PlayitProcess = Start-Process -FilePath $Dest -PassThru -NoNewWindow

Write-Host "Playit.exe has been launched successfully (PID: $($PlayitProcess.Id))!" -ForegroundColor Green
Write-Host "It will generate a claim registration link below in a few seconds..." -ForegroundColor Gray
