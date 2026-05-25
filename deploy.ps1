# Minecraft Network Auto-Deployer
$ErrorActionPreference = "Stop"

Write-Host "==============================================" -ForegroundColor Cyan
Write-Host "   Minecraft Hybrid Network Auto-Deployer   " -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan

# 1. Generate a new unique Forwarding Secret
Write-Host "`n[1/3] Generating secure forwarding secret..." -ForegroundColor White
$secret = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 12 | ForEach-Object {[char]$_})
$secretPath = "Minecraft_Network\1_Velocity_Proxy\forwarding.secret"
$secret | Out-File -FilePath $secretPath -NoNewline -Encoding ASCII
Write-Host "Done! Secret generated and saved." -ForegroundColor Green

# 2. Update Paper configuration with the new secret
Write-Host "[2/3] Syncing secret with Paper server..." -ForegroundColor White
$paperConfig = "Minecraft_Network\2_Paper_Server\config\paper-global.yml"
(Get-Content $paperConfig) -replace 'secret: .*', "secret: $secret" | Set-Content $paperConfig
Write-Host "Done! Handshake synchronized." -ForegroundColor Green

# 3. Download playit.gg agent if missing
Write-Host "[3/3] Checking for playit.gg tunnel agent..." -ForegroundColor White
$playitPath = "Minecraft_Network\playit.exe"
if (-not (Test-Path $playitPath)) {
    Write-Host "Downloading playit.exe..." -ForegroundColor Gray
    $url = "https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-windows-x86_64-signed.exe"
    Invoke-WebRequest -Uri $url -OutFile $playitPath
    Write-Host "Done! Tunnel agent downloaded." -ForegroundColor Green
} else {
    Write-Host "playit.exe already exists, skipping download." -ForegroundColor Yellow
}

Write-Host "`n==============================================" -ForegroundColor Cyan
Write-Host "DEPLOYMENT COMPLETE!" -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host "Next Steps:" -ForegroundColor White
Write-Host "1. Run 'restart_all.bat' to start the network." -ForegroundColor White
Write-Host "2. Claim your playit.gg link in the tunnel window." -ForegroundColor White
Write-Host "3. Join your server and enjoy!" -ForegroundColor White
pause
