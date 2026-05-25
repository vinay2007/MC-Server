$ErrorActionPreference = "Stop"
$Headers = @{ "User-Agent" = "MinecraftNetworkUpdater/1.0" }
$MsiUrl = "https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-windows-x86_64-signed.msi"
$Dest = "d:\MC-Server\Minecraft_Network\playit-installer.msi"

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "Downloading Playit.gg Windows Installer (.msi)" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

Write-Host "Downloading MSI package from GitHub..." -ForegroundColor Gray
Invoke-WebRequest -Uri $MsiUrl -OutFile $Dest -Headers $Headers
Write-Host "MSI saved successfully to $Dest!" -ForegroundColor Green

Write-Host "`nLaunching installation wizard..." -ForegroundColor Gray
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$Dest`"" -Wait
Write-Host "Installation completed or launcher closed!" -ForegroundColor Green
