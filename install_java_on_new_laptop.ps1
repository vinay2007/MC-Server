# PowerShell script to download and install Java 25.0.2
$ErrorActionPreference = "Stop"

# Official Oracle JDK 25.0.2 Installer URL
$JavaUrl = "https://download.oracle.com/java/25/latest/jdk-25_windows-x64_bin.msi"
$InstallerPath = "$env:TEMP\java25_installer.msi"

Write-Host "--- Downloading Java 25.0.2 (Oracle JDK) ---" -ForegroundColor Cyan
Invoke-WebRequest -Uri $JavaUrl -OutFile $InstallerPath

Write-Host "--- Starting Installation ---" -ForegroundColor Cyan
Write-Host "Please follow the installer prompts on your screen." -ForegroundColor Yellow

# Start the installer
Start-Process msiexec.exe -ArgumentList "/i `"$InstallerPath`"" -Wait

Write-Host "--- Java 25.0.2 Installation Complete ---" -ForegroundColor Green
Write-Host "You can now run your Minecraft server!" -ForegroundColor White
